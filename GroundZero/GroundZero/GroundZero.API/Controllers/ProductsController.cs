using Microsoft.AspNetCore.Authorization; using Microsoft.AspNetCore.Mvc;
using GroundZero.Application.Features.Products.Dtos;
using GroundZero.Application.Features.Products.Filters;
using GroundZero.Application.Features.Products.Services;
namespace GroundZero.API.Controllers;

[ApiController, Route("api/[controller]"), Authorize]
public class ProductsController : ControllerBase
{
    private readonly IProductService _svc;
    public ProductsController(IProductService svc) => _svc = svc;

    [HttpGet, AllowAnonymous]
    public async Task<IActionResult> GetAll([FromQuery] ProductFilter f, CancellationToken ct) => Ok(await _svc.GetPagedAsync(f, ct));
    [HttpGet("{id:guid}"), AllowAnonymous]
    public async Task<IActionResult> GetById(Guid id, CancellationToken ct) => Ok(await _svc.GetByIdAsync(id, ct));
    [HttpPost, Authorize(Roles = "Admin")]
    public async Task<IActionResult> Create([FromBody] CreateProductRequest req, CancellationToken ct)
    { var p = await _svc.CreateAsync(req, ct); return CreatedAtAction(nameof(GetById), new { id = p.Id }, p); }
    [HttpPut("{id:guid}"), Authorize(Roles = "Admin")]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateProductRequest req, CancellationToken ct) => Ok(await _svc.UpdateAsync(id, req, ct));
    [HttpDelete("{id:guid}"), Authorize(Roles = "Admin")]
    public async Task<IActionResult> Delete(Guid id, CancellationToken ct) { await _svc.DeleteAsync(id, ct); return NoContent(); }
}