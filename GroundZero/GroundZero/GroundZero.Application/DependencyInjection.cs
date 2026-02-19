using Microsoft.Extensions.DependencyInjection;
using GroundZero.Application.Features.Products.Services;
namespace GroundZero.Application;
public static class DependencyInjection
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    { services.AddScoped<IProductService, ProductService>(); return services; }
}