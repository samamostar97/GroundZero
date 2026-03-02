using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class UploadProductImageCommand : IRequest<ApiResponse<ProductResponse>>
{
    public int Id { get; set; }
    public Stream? FileStream { get; set; }
    public string FileName { get; set; } = string.Empty;
    public long FileSize { get; set; }
}
