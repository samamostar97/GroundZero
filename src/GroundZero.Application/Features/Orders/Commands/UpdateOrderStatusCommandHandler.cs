using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Orders.Commands;

public class UpdateOrderStatusCommandHandler : IRequestHandler<UpdateOrderStatusCommand, OrderResponse>
{
    private readonly IOrderRepository _orderRepository;
    private readonly IProductRepository _productRepository;

    public UpdateOrderStatusCommandHandler(IOrderRepository orderRepository, IProductRepository productRepository)
    {
        _orderRepository = orderRepository;
        _productRepository = productRepository;
    }

    public async Task<OrderResponse> Handle(UpdateOrderStatusCommand command, CancellationToken cancellationToken)
    {
        var order = await _orderRepository.GetByIdWithItemsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Narudžba", command.Id);

        ValidateStatusTransition(order.Status, command.Request.Status);

        // If cancelling, restore stock
        if (command.Request.Status == OrderStatus.Cancelled && order.Status != OrderStatus.Cancelled)
        {
            foreach (var item in order.Items)
            {
                var product = await _productRepository.GetByIdAsync(item.ProductId, cancellationToken);
                if (product != null)
                {
                    product.StockQuantity += item.Quantity;
                    _productRepository.Update(product);
                }
            }
        }

        order.Status = command.Request.Status;
        _orderRepository.Update(order);
        await _orderRepository.SaveChangesAsync(cancellationToken);

        return order.ToResponse();
    }

    private static void ValidateStatusTransition(OrderStatus current, OrderStatus next)
    {
        var validTransitions = new Dictionary<OrderStatus, OrderStatus[]>
        {
            { OrderStatus.Pending, new[] { OrderStatus.Confirmed, OrderStatus.Cancelled } },
            { OrderStatus.Confirmed, new[] { OrderStatus.Shipped, OrderStatus.Cancelled } },
            { OrderStatus.Shipped, new[] { OrderStatus.Delivered } },
            { OrderStatus.Delivered, Array.Empty<OrderStatus>() },
            { OrderStatus.Cancelled, Array.Empty<OrderStatus>() }
        };

        if (!validTransitions.ContainsKey(current) || !validTransitions[current].Contains(next))
            throw new InvalidOperationException(
                $"Nije moguće promijeniti status narudžbe iz '{current}' u '{next}'.");
    }
}
