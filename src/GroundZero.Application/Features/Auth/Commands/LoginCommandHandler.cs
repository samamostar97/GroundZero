using GroundZero.Application.Common;
using GroundZero.Application.Features.Auth.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class LoginCommandHandler : IRequestHandler<LoginCommand, ApiResponse<AuthResponse>>
{
    private readonly IUserRepository _userRepository;
    private readonly IRefreshTokenRepository _refreshTokenRepository;
    private readonly IJwtService _jwtService;
    private readonly IPasswordHasher _passwordHasher;

    public LoginCommandHandler(
        IUserRepository userRepository,
        IRefreshTokenRepository refreshTokenRepository,
        IJwtService jwtService,
        IPasswordHasher passwordHasher)
    {
        _userRepository = userRepository;
        _refreshTokenRepository = refreshTokenRepository;
        _jwtService = jwtService;
        _passwordHasher = passwordHasher;
    }

    public async Task<ApiResponse<AuthResponse>> Handle(LoginCommand command, CancellationToken cancellationToken)
    {
        var request = command.Request;

        var user = await _userRepository.GetByEmailAsync(request.Email.ToLower(), cancellationToken);

        if (user == null || !_passwordHasher.Verify(request.Password, user.PasswordHash))
            return ApiResponse<AuthResponse>.Fail("Pogrešan email ili lozinka.", 401);

        var accessToken = _jwtService.GenerateAccessToken(user);
        var refreshToken = _jwtService.GenerateRefreshToken();

        var refreshTokenExpiryDays = int.Parse(
            Environment.GetEnvironmentVariable("JWT_REFRESH_TOKEN_EXPIRY_DAYS") ?? "7");

        var refreshTokenEntity = new RefreshToken
        {
            Token = refreshToken,
            UserId = user.Id,
            ExpiresAt = DateTime.UtcNow.AddDays(refreshTokenExpiryDays)
        };

        await _refreshTokenRepository.AddAsync(refreshTokenEntity, cancellationToken);
        await _refreshTokenRepository.SaveChangesAsync(cancellationToken);

        var accessTokenExpiryMinutes = int.Parse(
            Environment.GetEnvironmentVariable("JWT_ACCESS_TOKEN_EXPIRY_MINUTES") ?? "30");

        return ApiResponse<AuthResponse>.Success(new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = refreshToken,
            AccessTokenExpiry = DateTime.UtcNow.AddMinutes(accessTokenExpiryMinutes)
        });
    }
}
