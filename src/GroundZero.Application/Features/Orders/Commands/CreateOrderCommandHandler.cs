using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using MediatR;

namespace GroundZero.Application.Features.Orders.Commands;

public class CreateOrderCommandHandler : IRequestHandler<CreateOrderCommand, OrderResponse>
{
    private readonly IOrderRepository _orderRepository;
    private readonly IProductRepository _productRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IStripeService _stripeService;
    private readonly IUserRepository _userRepository;
    private readonly IMessagePublisher _messagePublisher;

    public CreateOrderCommandHandler(
        IOrderRepository orderRepository,
        IProductRepository productRepository,
        ICurrentUserService currentUserService,
        IStripeService stripeService,
        IUserRepository userRepository,
        IMessagePublisher messagePublisher)
    {
        _orderRepository = orderRepository;
        _productRepository = productRepository;
        _currentUserService = currentUserService;
        _stripeService = stripeService;
        _userRepository = userRepository;
        _messagePublisher = messagePublisher;
    }

    public async Task<OrderResponse> Handle(CreateOrderCommand command, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var user = await _userRepository.GetByIdAsync(userId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", userId);

        var productIds = command.Request.Items.Select(i => i.ProductId).Distinct().ToList();
        var products = await _productRepository.FindAsync(p => productIds.Contains(p.Id), cancellationToken);

        if (products.Count != productIds.Count)
        {
            var foundIds = products.Select(p => p.Id).ToHashSet();
            var missingIds = productIds.Where(id => !foundIds.Contains(id)).ToList();
            throw new NotFoundException($"Proizvodi sa ID {string.Join(", ", missingIds)} nisu pronađeni.");
        }

        var orderItems = new List<OrderItem>();
        decimal totalAmount = 0;

        foreach (var itemRequest in command.Request.Items)
        {
            var product = products.First(p => p.Id == itemRequest.ProductId);

            if (product.StockQuantity < itemRequest.Quantity)
                throw new InvalidOperationException(
                    $"Nedovoljna količina proizvoda '{product.Name}' na stanju. Dostupno: {product.StockQuantity}, traženo: {itemRequest.Quantity}.");

            var orderItem = new OrderItem
            {
                ProductId = product.Id,
                Quantity = itemRequest.Quantity,
                UnitPrice = product.Price
            };

            orderItems.Add(orderItem);
            totalAmount += orderItem.UnitPrice * orderItem.Quantity;
        }

        var (paymentIntentId, clientSecret) = await _stripeService.CreatePaymentIntentAsync(totalAmount);

        var order = new Order
        {
            UserId = userId,
            TotalAmount = totalAmount,
            Status = OrderStatus.Pending,
            StripePaymentIntentId = paymentIntentId,
            Items = orderItems
        };

        // Decrement stock
        foreach (var itemRequest in command.Request.Items)
        {
            var product = products.First(p => p.Id == itemRequest.ProductId);
            product.StockQuantity -= itemRequest.Quantity;
            _productRepository.Update(product);
        }

        await _orderRepository.AddAsync(order, cancellationToken);
        await _orderRepository.SaveChangesAsync(cancellationToken);

        // Populate navigation properties for response
        order.User = user;
        foreach (var item in order.Items)
        {
            item.Product = products.First(p => p.Id == item.ProductId);
        }

        await _messagePublisher.PublishAsync(QueueNames.OrderCreated, new OrderCreatedEvent
        {
            Email = user.Email,
            OrderId = order.Id,
            TotalAmount = totalAmount,
            Items = order.Items.Select(i => new OrderItemInfo
            {
                ProductName = products.First(p => p.Id == i.ProductId).Name,
                Quantity = i.Quantity,
                UnitPrice = i.UnitPrice
            }).ToList()
        }, cancellationToken);

        return order.ToResponse(clientSecret);
    }
}
