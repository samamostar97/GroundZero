using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Categories.Commands;

public class DeleteCategoryCommand : IRequest<ApiResponse<string>>
{
    public int Id { get; set; }
}
