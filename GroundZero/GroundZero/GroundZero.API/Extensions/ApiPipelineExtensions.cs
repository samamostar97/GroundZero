using GroundZero.API.Middleware;
namespace GroundZero.API.Extensions;
public static class ApiPipelineExtensions
{
    public static WebApplication UseApiPipeline(this WebApplication app)
    { app.UseMiddleware<ExceptionMiddleware>();
      if (app.Environment.IsDevelopment()) { app.UseSwagger(); app.UseSwaggerUI(); }
      app.UseHttpsRedirection(); app.UseCors("AllowAll");
      app.UseAuthentication(); app.UseAuthorization(); app.MapControllers(); return app; }
}