using FluentAssertions;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.Commands;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using NSubstitute;
using ValidationException = GroundZero.Application.Exceptions.ValidationException;

namespace GroundZero.Application.Tests.Features.Products;

public class UploadProductImageCommandHandlerTests
{
    private readonly IProductRepository _productRepository;
    private readonly IFileService _fileService;
    private readonly UploadProductImageCommandHandler _handler;

    public UploadProductImageCommandHandlerTests()
    {
        _productRepository = Substitute.For<IProductRepository>();
        _fileService = Substitute.For<IFileService>();
        _handler = new UploadProductImageCommandHandler(_productRepository, _fileService);
    }

    [Fact]
    public async Task Handle_ValidUpload_ShouldReturnProductResponseWithImageUrl()
    {
        // Arrange
        var product = new Product
        {
            Id = 1,
            Name = "Whey Protein",
            Price = 49.99m,
            CategoryId = 1,
            Category = new ProductCategory { Id = 1, Name = "Suplementi" }
        };

        _productRepository.GetByIdWithCategoryAsync(1, Arg.Any<CancellationToken>()).Returns(product);

        var stream = new MemoryStream(new byte[] { 1, 2, 3 });
        _fileService.UploadFileAsync(stream, "image.jpg", "products")
            .Returns("uploads/products/image.jpg");

        var command = new UploadProductImageCommand
        {
            Id = 1,
            FileStream = stream,
            FileName = "image.jpg",
            FileSize = 3
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Should().BeOfType<ProductResponse>();
        result.ImageUrl.Should().Be("uploads/products/image.jpg");
        result.Name.Should().Be("Whey Protein");

        _productRepository.Received(1).Update(product);
        await _productRepository.Received(1).SaveChangesAsync(Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_ProductNotFound_ShouldThrowNotFoundException()
    {
        // Arrange
        _productRepository.GetByIdWithCategoryAsync(999, Arg.Any<CancellationToken>())
            .Returns((Product?)null);

        var command = new UploadProductImageCommand
        {
            Id = 999,
            FileStream = new MemoryStream(),
            FileName = "test.jpg"
        };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<NotFoundException>();
    }

    [Fact]
    public async Task Handle_NullFileStream_ShouldThrowValidationException()
    {
        // Arrange
        var product = new Product
        {
            Id = 1,
            Name = "Test",
            Category = new ProductCategory { Name = "Cat" }
        };

        _productRepository.GetByIdWithCategoryAsync(1, Arg.Any<CancellationToken>()).Returns(product);

        var command = new UploadProductImageCommand
        {
            Id = 1,
            FileStream = null,
            FileName = ""
        };

        // Act
        var act = () => _handler.Handle(command, CancellationToken.None);

        // Assert
        await act.Should().ThrowAsync<ValidationException>()
            .Where(ex => ex.Errors.Contains("Fajl je obavezan."));
    }

    [Fact]
    public async Task Handle_ExistingImage_ShouldDeleteOldAndUploadNew()
    {
        // Arrange
        var product = new Product
        {
            Id = 1,
            Name = "Protein",
            ImageUrl = "uploads/products/old.jpg",
            Category = new ProductCategory { Name = "Suplementi" }
        };

        _productRepository.GetByIdWithCategoryAsync(1, Arg.Any<CancellationToken>()).Returns(product);

        var stream = new MemoryStream(new byte[] { 1, 2, 3 });
        _fileService.UploadFileAsync(stream, "new.jpg", "products")
            .Returns("uploads/products/new.jpg");

        var command = new UploadProductImageCommand
        {
            Id = 1,
            FileStream = stream,
            FileName = "new.jpg",
            FileSize = 3
        };

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        _fileService.Received(1).DeleteFile("uploads/products/old.jpg");
        result.ImageUrl.Should().Be("uploads/products/new.jpg");
    }

    [Fact]
    public async Task Handle_NoExistingImage_ShouldNotCallDelete()
    {
        // Arrange
        var product = new Product
        {
            Id = 1,
            Name = "New Product",
            ImageUrl = null,
            Category = new ProductCategory { Name = "Cat" }
        };

        _productRepository.GetByIdWithCategoryAsync(1, Arg.Any<CancellationToken>()).Returns(product);

        var stream = new MemoryStream(new byte[] { 1 });
        _fileService.UploadFileAsync(stream, "first.jpg", "products")
            .Returns("uploads/products/first.jpg");

        var command = new UploadProductImageCommand
        {
            Id = 1,
            FileStream = stream,
            FileName = "first.jpg",
            FileSize = 1
        };

        // Act
        await _handler.Handle(command, CancellationToken.None);

        // Assert
        _fileService.DidNotReceive().DeleteFile(Arg.Any<string>());
    }
}
