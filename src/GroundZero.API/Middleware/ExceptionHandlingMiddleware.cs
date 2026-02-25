using System.Net;
using System.Text.Json;
using GroundZero.Application.Exceptions;
using ValidationException = GroundZero.Application.Exceptions.ValidationException;

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
            _logger.LogError(ex, "An unhandled exception occurred");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";

        var (statusCode, result) = exception switch
        {
            ValidationException validationEx => (
                (int)HttpStatusCode.BadRequest,
                JsonSerializer.Serialize(new { errors = validationEx.Errors })),

            NotFoundException => (
                (int)HttpStatusCode.NotFound,
                JsonSerializer.Serialize(new { error = exception.Message })),

            ConflictException => (
                (int)HttpStatusCode.Conflict,
                JsonSerializer.Serialize(new { error = exception.Message })),

            UnauthorizedAccessException => (
                (int)HttpStatusCode.Unauthorized,
                JsonSerializer.Serialize(new { error = exception.Message })),

            ForbiddenException => (
                (int)HttpStatusCode.Forbidden,
                JsonSerializer.Serialize(new { error = exception.Message })),

            EntityHasDependentsException => (
                (int)HttpStatusCode.Conflict,
                JsonSerializer.Serialize(new { error = exception.Message })),

            KeyNotFoundException => (
                (int)HttpStatusCode.NotFound,
                JsonSerializer.Serialize(new { error = exception.Message })),

            InvalidOperationException => (
                (int)HttpStatusCode.BadRequest,
                JsonSerializer.Serialize(new { error = exception.Message })),

            _ => (
                (int)HttpStatusCode.InternalServerError,
                JsonSerializer.Serialize(new { error = "An internal server error occurred." }))
        };

        context.Response.StatusCode = statusCode;
        await context.Response.WriteAsync(result);
    }
}
