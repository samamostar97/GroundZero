using GroundZero.Application.Features.Categories.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Categories.Queries;

public class GetAllCategoriesQueryHandler : IRequestHandler<GetAllCategoriesQuery, List<CategoryResponse>>
{
    private readonly ICategoryRepository _categoryRepository;

    public GetAllCategoriesQueryHandler(ICategoryRepository categoryRepository)
    {
        _categoryRepository = categoryRepository;
    }

    public async Task<List<CategoryResponse>> Handle(GetAllCategoriesQuery query, CancellationToken cancellationToken)
    {
        var categories = await _categoryRepository.GetAllAsync(cancellationToken);

        var result = categories.Select(c => new CategoryResponse
        {
            Id = c.Id,
            Name = c.Name,
            Description = c.Description
        }).ToList();

        return result;
    }
}
