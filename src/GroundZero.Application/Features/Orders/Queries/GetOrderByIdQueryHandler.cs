using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Orders.Queries;

public class GetOrderByIdQueryHandler : IRequestHandler<GetOrderByIdQuery, OrderResponse>
{
    private readonly IOrderRepository _orderRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetOrderByIdQueryHandler(IOrderRepository orderRepository, ICurrentUserService currentUserService)
    {
        _orderRepository = orderRepository;
        _currentUserService = currentUserService;
    }

    public async Task<OrderResponse> Handle(GetOrderByIdQuery query, CancellationToken cancellationToken)
    {
        var order = await _orderRepository.GetByIdWithItemsAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Narudžba", query.Id);

        // Users can only view their own orders, Admin can view all
        if (_currentUserService.Role != "Admin" && order.UserId != _currentUserService.UserId)
            throw new ForbiddenException("Nemate pristup ovoj narudžbi.");

        return order.ToResponse();
    }
}
