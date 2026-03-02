using FluentAssertions;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.Commands;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using NSubstitute;

namespace GroundZero.Application.Tests.Features.Products;

public class CreateProductCommandHandlerTests
{
    private readonly IProductRepository _productRepository;
    private readonly ICategoryRepository _categoryRepository;
    private readonly CreateProductCommandHandler _handler;

    public CreateProductCommandHandlerTests()
    {
        _productRepository = Substitute.For<IProductRepository>();
        _categoryRepository = Substitute.For<ICategoryRepository>();
        _handler = new CreateProductCommandHandler(_productRepository, _categoryRepository);
    }

    [Fact]
    public async Task Handle_ValidRequest_ShouldReturnProductResponse()
    {
        // Arrange
        var category = new ProductCategory { Id = 1, Name = "Suplementi" };
        _categoryRepository.GetByIdAsync(1, Arg.Any<CancellationToken>()).Returns(category);

        _productRepository.AddAsync(Arg.Any<Product>(), Arg.Any<CancellationToken>())
            .Returns(callInfo =>
            {
                var product = callInfo.Arg<Product>();
                product.Id = 10;
                return product;
            });

        var command = new CreateProductCommand
        {
            Request = new CreateProductRequest
            {
                Name = "Whey Protein",
                Description = "Protein powder",
                Price = 49.99m,
                StockQuantity = 100,
                CategoryId = 1
            }
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Should().BeOfType<ProductResponse>();
        result.Name.Should().Be("Whey Protein");
        result.Price.Should().Be(49.99m);
        result.StockQuantity.Should().Be(100);
        result.CategoryId.Should().Be(1);
        result.CategoryName.Should().Be("Suplementi");

        await _productRepository.Received(1).AddAsync(Arg.Any<Product>(), Arg.Any<CancellationToken>());
        await _productRepository.Received(1).SaveChangesAsync(Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_CategoryNotFound_ShouldThrowNotFoundException()
    {
        // Arrange
        _categoryRepository.GetByIdAsync(999, Arg.Any<CancellationToken>())
            .Returns((ProductCategory?)null);

        var command = new CreateProductCommand
        {
            Request = new CreateProductRequest
            {
                Name = "Test",
                Price = 10m,
                CategoryId = 999
            }
        };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<NotFoundException>();
    }

    [Fact]
    public async Task Handle_ValidRequest_ShouldSetCategoryOnProduct()
    {
        // Arrange
        var category = new ProductCategory { Id = 2, Name = "Oprema" };
        _categoryRepository.GetByIdAsync(2, Arg.Any<CancellationToken>()).Returns(category);

        _productRepository.AddAsync(Arg.Any<Product>(), Arg.Any<CancellationToken>())
            .Returns(callInfo => callInfo.Arg<Product>());

        var command = new CreateProductCommand
        {
            Request = new CreateProductRequest
            {
                Name = "Rukavice",
                Price = 25m,
                StockQuantity = 50,
                CategoryId = 2
            }
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.CategoryName.Should().Be("Oprema");
    }
}
