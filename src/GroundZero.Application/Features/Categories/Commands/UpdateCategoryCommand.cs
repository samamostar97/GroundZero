using GroundZero.Application.Common;
using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

[AuthorizeRole("Admin")]
public class UpdateCategoryCommand : IRequest<CategoryResponse>
{
    public int Id { get; set; }
    public UpdateCategoryRequest Request { get; set; } = null!;
}
