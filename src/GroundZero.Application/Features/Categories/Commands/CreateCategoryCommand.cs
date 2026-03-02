using GroundZero.Application.Common;
using GroundZero.Application.Features.Categories.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

[AuthorizeRole("Admin")]
public class CreateCategoryCommand : IRequest<CategoryResponse>
{
    public CreateCategoryRequest Request { get; set; } = null!;
}
