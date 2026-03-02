using FluentAssertions;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.Commands;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using MediatR;
using NSubstitute;

namespace GroundZero.Application.Tests.Features.Users;

public class DeleteUserCommandHandlerTests
{
    private readonly IUserRepository _userRepository;
    private readonly DeleteUserCommandHandler _handler;

    public DeleteUserCommandHandlerTests()
    {
        _userRepository = Substitute.For<IUserRepository>();
        _handler = new DeleteUserCommandHandler(_userRepository);
    }

    [Fact]
    public async Task Handle_ValidUser_ShouldSoftDeleteAndReturnUnit()
    {
        // Arrange
        var user = new User
        {
            Id = 5,
            Email = "user@test.com",
            Role = Role.User
        };

        _userRepository.GetByIdAsync(5, Arg.Any<CancellationToken>()).Returns(user);

        var command = new DeleteUserCommand { Id = 5 };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().Be(Unit.Value);
        _userRepository.Received(1).SoftDelete(user);
        await _userRepository.Received(1).SaveChangesAsync(Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_UserNotFound_ShouldThrowNotFoundException()
    {
        // Arrange
        _userRepository.GetByIdAsync(999, Arg.Any<CancellationToken>()).Returns((User?)null);

        var command = new DeleteUserCommand { Id = 999 };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<NotFoundException>();
    }

    [Fact]
    public async Task Handle_AdminUser_ShouldThrowInvalidOperationException()
    {
        // Arrange
        var admin = new User
        {
            Id = 1,
            Email = "desktop",
            Role = Role.Admin
        };

        _userRepository.GetByIdAsync(1, Arg.Any<CancellationToken>()).Returns(admin);

        var command = new DeleteUserCommand { Id = 1 };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<InvalidOperationException>()
            .WithMessage("Nije moguće obrisati administratora.");
    }

    [Fact]
    public async Task Handle_AdminUser_ShouldNotCallSoftDelete()
    {
        // Arrange
        var admin = new User { Id = 1, Role = Role.Admin };
        _userRepository.GetByIdAsync(1, Arg.Any<CancellationToken>()).Returns(admin);

        var command = new DeleteUserCommand { Id = 1 };

        // Act
        try { await _handler.Handle(command, CancellationToken.None); } catch { }

        // Assert
        _userRepository.DidNotReceive().SoftDelete(Arg.Any<User>());
    }
}
