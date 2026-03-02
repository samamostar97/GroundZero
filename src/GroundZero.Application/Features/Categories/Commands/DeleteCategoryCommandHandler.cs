using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class DeleteCategoryCommandHandler : IRequestHandler<DeleteCategoryCommand, Unit>
{
    private readonly ICategoryRepository _categoryRepository;

    public DeleteCategoryCommandHandler(ICategoryRepository categoryRepository)
    {
        _categoryRepository = categoryRepository;
    }

    public async Task<Unit> Handle(DeleteCategoryCommand command, CancellationToken cancellationToken)
    {
        var category = await _categoryRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Kategorija", command.Id);

        if (await _categoryRepository.HasProductsAsync(command.Id, cancellationToken))
            throw new ConflictException("Nije moguće obrisati kategoriju koja ima proizvode.");

        _categoryRepository.SoftDelete(category);
        await _categoryRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
