using GroundZero.Application.Common;
using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class UpdateCategoryCommand : IRequest<ApiResponse<CategoryResponse>>
{
    public int Id { get; set; }
    public UpdateCategoryRequest Request { get; set; } = null!;
}
