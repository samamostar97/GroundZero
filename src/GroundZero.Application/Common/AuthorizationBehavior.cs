using System.Reflection;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Common;

public class AuthorizationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly ICurrentUserService _currentUserService;

    public AuthorizationBehavior(ICurrentUserService currentUserService)
    {
        _currentUserService = currentUserService;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var authorizeAttribute = typeof(TRequest).GetCustomAttribute<AuthorizeRoleAttribute>();

        if (authorizeAttribute is null)
            return await next();

        if (!_currentUserService.IsAuthenticated)
            throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        if (_currentUserService.Role != authorizeAttribute.Role)
            throw new ForbiddenException();

        return await next();
    }
}
