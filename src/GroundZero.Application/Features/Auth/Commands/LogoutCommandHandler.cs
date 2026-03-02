using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class LogoutCommandHandler : IRequestHandler<LogoutCommand, ApiResponse<string>>
{
    private readonly IRefreshTokenRepository _refreshTokenRepository;

    public LogoutCommandHandler(IRefreshTokenRepository refreshTokenRepository)
    {
        _refreshTokenRepository = refreshTokenRepository;
    }

    public async Task<ApiResponse<string>> Handle(LogoutCommand command, CancellationToken cancellationToken)
    {
        await _refreshTokenRepository.RevokeAllForUserAsync(command.UserId, cancellationToken);
        await _refreshTokenRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<string>.Success("Uspješno ste se odjavili.");
    }
}
