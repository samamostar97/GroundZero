using GroundZero.Application.Common;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Orders.Queries;

public class GetUserOrdersQueryHandler : IRequestHandler<GetUserOrdersQuery, PagedResult<OrderResponse>>
{
    private readonly IOrderRepository _orderRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserOrdersQueryHandler(IOrderRepository orderRepository, ICurrentUserService currentUserService)
    {
        _orderRepository = orderRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<OrderResponse>> Handle(GetUserOrdersQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var paged = await _orderRepository.GetUserOrdersPagedAsync(
            userId, query.Status, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<OrderResponse>
        {
            Items = paged.Items.Select(o => o.ToResponse()).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
