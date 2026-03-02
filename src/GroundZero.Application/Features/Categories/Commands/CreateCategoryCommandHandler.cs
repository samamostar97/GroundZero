using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Categories.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class CreateCategoryCommandHandler : IRequestHandler<CreateCategoryCommand, ApiResponse<CategoryResponse>>
{
    private readonly ICategoryRepository _categoryRepository;

    public CreateCategoryCommandHandler(ICategoryRepository categoryRepository)
    {
        _categoryRepository = categoryRepository;
    }

    public async Task<ApiResponse<CategoryResponse>> Handle(CreateCategoryCommand command, CancellationToken cancellationToken)
    {
        if (await _categoryRepository.NameExistsAsync(command.Request.Name, cancellationToken: cancellationToken))
            throw new ConflictException("Kategorija sa navedenim nazivom već postoji.");

        var category = new ProductCategory
        {
            Name = command.Request.Name,
            Description = command.Request.Description
        };

        await _categoryRepository.AddAsync(category, cancellationToken);
        await _categoryRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<CategoryResponse>.Success(new CategoryResponse
        {
            Id = category.Id,
            Name = category.Name,
            Description = category.Description
        }, 201);
    }
}
