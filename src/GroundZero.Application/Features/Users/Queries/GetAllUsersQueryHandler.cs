using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetAllUsersQueryHandler : IRequestHandler<GetAllUsersQuery, PagedResult<UserResponse>>
{
    private readonly IUserRepository _userRepository;

    public GetAllUsersQueryHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<PagedResult<UserResponse>> Handle(GetAllUsersQuery query, CancellationToken cancellationToken)
    {
        var pagedUsers = await _userRepository.GetPagedAsync(query.Search, query.SortBy, query.SortDescending, query.PageNumber, query.PageSize, query.HasActiveMembership, cancellationToken);

        var result = new PagedResult<UserResponse>
        {
            Items = pagedUsers.Items.Select(u => new UserResponse
            {
                Id = u.Id,
                FirstName = u.FirstName,
                LastName = u.LastName,
                Email = u.Email,
                ProfileImageUrl = u.ProfileImageUrl,
                Role = u.Role.ToString(),
                Level = u.Level,
                XP = u.XP,
                TotalGymMinutes = u.TotalGymMinutes,
                CreatedAt = u.CreatedAt
            }).ToList(),
            TotalCount = pagedUsers.TotalCount,
            PageNumber = pagedUsers.PageNumber,
            PageSize = pagedUsers.PageSize
        };

        return result;
    }
}
