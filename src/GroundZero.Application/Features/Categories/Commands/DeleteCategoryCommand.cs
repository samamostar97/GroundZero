using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

[AuthorizeRole("Admin")]
public class DeleteCategoryCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
