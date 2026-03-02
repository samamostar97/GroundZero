using GroundZero.Application.Common;
using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class CreateCategoryCommand : IRequest<ApiResponse<CategoryResponse>>
{
    public CreateCategoryRequest Request { get; set; } = null!;
}
