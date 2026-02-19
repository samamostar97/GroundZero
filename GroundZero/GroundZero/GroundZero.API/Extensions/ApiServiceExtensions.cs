using Microsoft.OpenApi.Models;
namespace GroundZero.API.Extensions;
public static class ApiServiceExtensions
{
    public static IServiceCollection AddApiServices(this IServiceCollection s)
    {
        s.AddControllers(); s.AddEndpointsApiExplorer(); s.AddHttpContextAccessor();
        s.AddSwaggerGen(o => { o.SwaggerDoc("v1", new OpenApiInfo { Title = "GroundZero API", Version = "v1" });
            o.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme { Name = "Authorization", Type = SecuritySchemeType.Http,
                Scheme = "Bearer", BearerFormat = "JWT", In = ParameterLocation.Header });
            o.AddSecurityRequirement(new OpenApiSecurityRequirement { { new OpenApiSecurityScheme
                { Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "Bearer" } }, Array.Empty<string>() } }); });
        s.AddCors(o => o.AddPolicy("AllowAll", p => p.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));
        return s;
    }
}