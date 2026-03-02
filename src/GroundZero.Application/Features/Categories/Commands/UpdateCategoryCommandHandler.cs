using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Categories.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class UpdateCategoryCommandHandler : IRequestHandler<UpdateCategoryCommand, CategoryResponse>
{
    private readonly ICategoryRepository _categoryRepository;

    public UpdateCategoryCommandHandler(ICategoryRepository categoryRepository)
    {
        _categoryRepository = categoryRepository;
    }

    public async Task<CategoryResponse> Handle(UpdateCategoryCommand command, CancellationToken cancellationToken)
    {
        var category = await _categoryRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Kategorija", command.Id);

        if (await _categoryRepository.NameExistsAsync(command.Request.Name, command.Id, cancellationToken))
            throw new ConflictException("Kategorija sa navedenim nazivom već postoji.");

        category.Name = command.Request.Name;
        category.Description = command.Request.Description;

        _categoryRepository.Update(category);
        await _categoryRepository.SaveChangesAsync(cancellationToken);

        return new CategoryResponse
        {
            Id = category.Id,
            Name = category.Name,
            Description = category.Description
        };
    }
}
