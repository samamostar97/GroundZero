using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Queries;

public class GetAllCategoriesQuery : IRequest<List<CategoryResponse>>
{
}
