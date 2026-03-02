using GroundZero.Application.Common;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Orders.Queries;

[AuthorizeRole("User")]
public class GetUserOrdersQuery : IRequest<PagedResult<OrderResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public OrderStatus? Status { get; set; }
}
