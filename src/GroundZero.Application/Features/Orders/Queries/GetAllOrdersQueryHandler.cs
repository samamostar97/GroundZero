using GroundZero.Application.Common;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Orders.Queries;

public class GetAllOrdersQueryHandler : IRequestHandler<GetAllOrdersQuery, PagedResult<OrderResponse>>
{
    private readonly IOrderRepository _orderRepository;

    public GetAllOrdersQueryHandler(IOrderRepository orderRepository)
    {
        _orderRepository = orderRepository;
    }

    public async Task<PagedResult<OrderResponse>> Handle(GetAllOrdersQuery query, CancellationToken cancellationToken)
    {
        var paged = await _orderRepository.GetAllOrdersPagedAsync(
            query.Search, query.Status, query.UserId,
            query.SortBy, query.SortDescending, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<OrderResponse>
        {
            Items = paged.Items.Select(o => o.ToResponse()).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
