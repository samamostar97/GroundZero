using GroundZero.Application.Features.Auth.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, AuthResponse>
{
    private readonly IRefreshTokenRepository _refreshTokenRepository;
    private readonly IUserRepository _userRepository;
    private readonly IJwtService _jwtService;

    public RefreshTokenCommandHandler(
        IRefreshTokenRepository refreshTokenRepository,
        IUserRepository userRepository,
        IJwtService jwtService)
    {
        _refreshTokenRepository = refreshTokenRepository;
        _userRepository = userRepository;
        _jwtService = jwtService;
    }

    public async Task<AuthResponse> Handle(RefreshTokenCommand command, CancellationToken cancellationToken)
    {
        var existingToken = await _refreshTokenRepository.GetByTokenAsync(command.Request.RefreshToken, cancellationToken);

        if (existingToken == null || existingToken.RevokedAt != null || existingToken.ExpiresAt <= DateTime.UtcNow)
            throw new UnauthorizedAccessException("Refresh token nije validan ili je istekao.");

        var user = await _userRepository.GetByIdAsync(existingToken.UserId, cancellationToken);
        if (user == null)
            throw new UnauthorizedAccessException("Korisnik nije pronađen.");

        // Revoke old token
        existingToken.RevokedAt = DateTime.UtcNow;
        _refreshTokenRepository.Update(existingToken);

        // Generate new tokens
        var accessToken = _jwtService.GenerateAccessToken(user);
        var newRefreshToken = _jwtService.GenerateRefreshToken();

        var refreshTokenExpiryDays = int.Parse(
            Environment.GetEnvironmentVariable("JWT_REFRESH_TOKEN_EXPIRY_DAYS") ?? "7");

        var newRefreshTokenEntity = new RefreshToken
        {
            Token = newRefreshToken,
            UserId = user.Id,
            ExpiresAt = DateTime.UtcNow.AddDays(refreshTokenExpiryDays)
        };

        await _refreshTokenRepository.AddAsync(newRefreshTokenEntity, cancellationToken);
        await _refreshTokenRepository.SaveChangesAsync(cancellationToken);

        var accessTokenExpiryMinutes = int.Parse(
            Environment.GetEnvironmentVariable("JWT_ACCESS_TOKEN_EXPIRY_MINUTES") ?? "30");

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = newRefreshToken,
            AccessTokenExpiry = DateTime.UtcNow.AddMinutes(accessTokenExpiryMinutes)
        };
    }
}
