using FluentAssertions;
using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IServices;
using MediatR;
using NSubstitute;

namespace GroundZero.Application.Tests.Common;

public class AuthorizationBehaviorTests
{
    private readonly ICurrentUserService _currentUserService;

    public AuthorizationBehaviorTests()
    {
        _currentUserService = Substitute.For<ICurrentUserService>();
    }

    private AuthorizationBehavior<TRequest, TResponse> CreateBehavior<TRequest, TResponse>()
        where TRequest : IRequest<TResponse>
    {
        return new AuthorizationBehavior<TRequest, TResponse>(_currentUserService);
    }

    private static RequestHandlerDelegate<T> NextReturning<T>(T value)
        => ct => Task.FromResult(value);

    [Fact]
    public async Task Handle_NoAuthorizeAttribute_ShouldCallNext()
    {
        // Arrange
        var behavior = CreateBehavior<CommandWithoutAuth, string>();
        var nextCalled = false;
        RequestHandlerDelegate<string> next = ct =>
        {
            nextCalled = true;
            return Task.FromResult("success");
        };

        // Act
        var result = await behavior.Handle(new CommandWithoutAuth(), next, CancellationToken.None);

        // Assert
        result.Should().Be("success");
        nextCalled.Should().BeTrue();
    }

    [Fact]
    public async Task Handle_AuthorizedAdmin_ShouldCallNext()
    {
        // Arrange
        _currentUserService.IsAuthenticated.Returns(true);
        _currentUserService.Role.Returns("Admin");

        var behavior = CreateBehavior<CommandWithAdminAuth, string>();

        // Act
        var result = await behavior.Handle(new CommandWithAdminAuth(), NextReturning("admin-ok"), CancellationToken.None);

        // Assert
        result.Should().Be("admin-ok");
    }

    [Fact]
    public async Task Handle_UnauthenticatedUser_ShouldThrowUnauthorizedAccessException()
    {
        // Arrange
        _currentUserService.IsAuthenticated.Returns(false);
        var behavior = CreateBehavior<CommandWithAdminAuth, string>();

        // Act
        var act = () => behavior.Handle(new CommandWithAdminAuth(), NextReturning(""), CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<UnauthorizedAccessException>()
            .WithMessage("Morate biti prijavljeni.");
    }

    [Fact]
    public async Task Handle_WrongRole_ShouldThrowForbiddenException()
    {
        // Arrange
        _currentUserService.IsAuthenticated.Returns(true);
        _currentUserService.Role.Returns("User");
        var behavior = CreateBehavior<CommandWithAdminAuth, string>();

        // Act
        var act = () => behavior.Handle(new CommandWithAdminAuth(), NextReturning(""), CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<ForbiddenException>();
    }

    [Fact]
    public async Task Handle_AdminAccessingUnitCommand_ShouldReturnUnit()
    {
        // Arrange
        _currentUserService.IsAuthenticated.Returns(true);
        _currentUserService.Role.Returns("Admin");
        var behavior = CreateBehavior<CommandWithAdminAuthUnit, Unit>();

        // Act
        var result = await behavior.Handle(new CommandWithAdminAuthUnit(), NextReturning(Unit.Value), CancellationToken.None);

        // Assert
        result.Should().Be(Unit.Value);
    }

    // Test commands
    public class CommandWithoutAuth : IRequest<string> { }

    [AuthorizeRole("Admin")]
    public class CommandWithAdminAuth : IRequest<string> { }

    [AuthorizeRole("Admin")]
    public class CommandWithAdminAuthUnit : IRequest<Unit> { }
}
