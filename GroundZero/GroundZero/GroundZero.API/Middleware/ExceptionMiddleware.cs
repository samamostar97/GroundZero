using System.Net; using System.Text.Json;
using GroundZero.Application.Common.Exceptions;
namespace GroundZero.API.Middleware;
public class ExceptionMiddleware
{
    private readonly RequestDelegate _next; private readonly ILogger<ExceptionMiddleware> _log;
    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> log) { _next = next; _log = log; }
    public async Task InvokeAsync(HttpContext ctx)
    { try { await _next(ctx); } catch (Exception ex) { _log.LogError(ex, "Unhandled"); await Handle(ctx, ex); } }
    private static async Task Handle(HttpContext ctx, Exception ex)
    {
        ctx.Response.ContentType = "application/json";
        var (code, resp) = ex switch {
            ValidationException v => (HttpStatusCode.BadRequest, new ErrResp("Validation Error", v.Errors)),
            NotFoundException n => (HttpStatusCode.NotFound, new ErrResp(n.Message)),
            UnauthorizedAccessException => (HttpStatusCode.Unauthorized, new ErrResp("Unauthorized")),
            _ => (HttpStatusCode.InternalServerError, new ErrResp("An unexpected error occurred.")) };
        ctx.Response.StatusCode = (int)code;
        await ctx.Response.WriteAsync(JsonSerializer.Serialize(resp, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase }));
    }
}
public record ErrResp(string Message, IDictionary<string, string[]>? Errors = null);