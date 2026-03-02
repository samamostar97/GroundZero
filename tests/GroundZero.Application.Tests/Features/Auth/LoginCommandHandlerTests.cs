using FluentAssertions;
using GroundZero.Application.Features.Auth.Commands;
using GroundZero.Application.Features.Auth.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using NSubstitute;

namespace GroundZero.Application.Tests.Features.Auth;

public class LoginCommandHandlerTests
{
    private readonly IUserRepository _userRepository;
    private readonly IRefreshTokenRepository _refreshTokenRepository;
    private readonly IJwtService _jwtService;
    private readonly IPasswordHasher _passwordHasher;
    private readonly LoginCommandHandler _handler;

    public LoginCommandHandlerTests()
    {
        _userRepository = Substitute.For<IUserRepository>();
        _refreshTokenRepository = Substitute.For<IRefreshTokenRepository>();
        _jwtService = Substitute.For<IJwtService>();
        _passwordHasher = Substitute.For<IPasswordHasher>();

        _handler = new LoginCommandHandler(
            _userRepository,
            _refreshTokenRepository,
            _jwtService,
            _passwordHasher);

        // Set env vars for token expiry
        Environment.SetEnvironmentVariable("JWT_REFRESH_TOKEN_EXPIRY_DAYS", "7");
        Environment.SetEnvironmentVariable("JWT_ACCESS_TOKEN_EXPIRY_MINUTES", "30");
    }

    [Fact]
    public async Task Handle_ValidCredentials_ShouldReturnAuthResponse()
    {
        // Arrange
        var user = new User
        {
            Id = 1,
            Email = "test@test.com",
            PasswordHash = "hashed",
            FirstName = "Test",
            LastName = "User",
            Role = Role.User
        };

        _userRepository.GetByEmailAsync("test@test.com", Arg.Any<CancellationToken>())
            .Returns(user);
        _passwordHasher.Verify("password123", "hashed").Returns(true);
        _jwtService.GenerateAccessToken(user).Returns("access-token-123");
        _jwtService.GenerateRefreshToken().Returns("refresh-token-456");

        var command = new LoginCommand
        {
            Request = new LoginRequest { Email = "test@test.com", Password = "password123" }
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Should().BeOfType<AuthResponse>();
        result.AccessToken.Should().Be("access-token-123");
        result.RefreshToken.Should().Be("refresh-token-456");
        result.AccessTokenExpiry.Should().BeCloseTo(DateTime.UtcNow.AddMinutes(30), TimeSpan.FromSeconds(5));

        await _refreshTokenRepository.Received(1).AddAsync(
            Arg.Is<RefreshToken>(rt => rt.Token == "refresh-token-456" && rt.UserId == 1),
            Arg.Any<CancellationToken>());
        await _refreshTokenRepository.Received(1).SaveChangesAsync(Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_UserNotFound_ShouldThrowUnauthorizedAccessException()
    {
        // Arrange
        _userRepository.GetByEmailAsync("bad@test.com", Arg.Any<CancellationToken>())
            .Returns((User?)null);

        var command = new LoginCommand
        {
            Request = new LoginRequest { Email = "bad@test.com", Password = "any" }
        };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<UnauthorizedAccessException>()
            .WithMessage("Pogrešan email ili lozinka.");
    }

    [Fact]
    public async Task Handle_WrongPassword_ShouldThrowUnauthorizedAccessException()
    {
        // Arrange
        var user = new User { Id = 1, Email = "test@test.com", PasswordHash = "hashed" };

        _userRepository.GetByEmailAsync("test@test.com", Arg.Any<CancellationToken>())
            .Returns(user);
        _passwordHasher.Verify("wrong-password", "hashed").Returns(false);

        var command = new LoginCommand
        {
            Request = new LoginRequest { Email = "test@test.com", Password = "wrong-password" }
        };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<UnauthorizedAccessException>()
            .WithMessage("Pogrešan email ili lozinka.");
    }

    [Fact]
    public async Task Handle_AdminLogin_ShouldReturnAuthResponse()
    {
        // Arrange
        var admin = new User
        {
            Id = 1,
            Email = "desktop",
            PasswordHash = "hashed-admin",
            Role = Role.Admin
        };

        _userRepository.GetByEmailAsync("desktop", Arg.Any<CancellationToken>())
            .Returns(admin);
        _passwordHasher.Verify("test", "hashed-admin").Returns(true);
        _jwtService.GenerateAccessToken(admin).Returns("admin-token");
        _jwtService.GenerateRefreshToken().Returns("admin-refresh");

        var command = new LoginCommand
        {
            Request = new LoginRequest { Email = "desktop", Password = "test" }
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.AccessToken.Should().Be("admin-token");
        result.RefreshToken.Should().Be("admin-refresh");
    }
}
