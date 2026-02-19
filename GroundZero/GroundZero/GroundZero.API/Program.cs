using Microsoft.AspNetCore.Identity;
using GroundZero.Application; using GroundZero.Infrastructure;
using GroundZero.Infrastructure.Persistence; using GroundZero.Infrastructure.Persistence.Seeding;
using GroundZero.API.Extensions;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddApplication().AddInfrastructure(builder.Configuration).AddApiServices();
var app = builder.Build();
using (var scope = app.Services.CreateScope())
{ var svc = scope.ServiceProvider;
  try { await IdentitySeeder.SeedAsync(svc.GetRequiredService<UserManager<IdentityUser>>(), svc.GetRequiredService<RoleManager<IdentityRole>>()); }
  catch (Exception ex) { svc.GetRequiredService<ILogger<Program>>().LogError(ex, "Seeding error."); } }
app.UseApiPipeline(); app.Run();