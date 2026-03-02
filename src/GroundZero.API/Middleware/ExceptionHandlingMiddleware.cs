using System.Text.Json;
using GroundZero.Application.Exceptions;

namespace GroundZero.API.Middleware;

public class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionHandlingMiddleware> _logger;

    public ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleExceptionAsync(context, ex);
        }
    }

    private async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var (statusCode, errors) = exception switch
        {
            ValidationException validationEx => (400, validationEx.Errors),
            InvalidOperationException => (400, new List<string> { exception.Message }),
            UnauthorizedAccessException => (401, new List<string> { exception.Message }),
            ForbiddenException => (403, new List<string> { exception.Message }),
            NotFoundException => (404, new List<string> { exception.Message }),
            KeyNotFoundException => (404, new List<string> { exception.Message }),
            ConflictException => (409, new List<string> { exception.Message }),
            _ => (500, new List<string> { "Došlo je do greške na serveru." })
        };

        if (statusCode == 500)
            _logger.LogError(exception, "Unhandled exception");
        else
            _logger.LogWarning(exception, "Handled exception: {Message}", exception.Message);

        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/json";

        var response = new
        {
            errors,
            statusCode
        };

        var jsonOptions = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
        await context.Response.WriteAsync(JsonSerializer.Serialize(response, jsonOptions));
    }
}
