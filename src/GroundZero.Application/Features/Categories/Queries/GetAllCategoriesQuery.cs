using GroundZero.Application.Common;
using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Queries;

public class GetAllCategoriesQuery : IRequest<ApiResponse<List<CategoryResponse>>>
{
}
