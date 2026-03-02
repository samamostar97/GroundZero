using DotNetEnv;
using GroundZero.API.Extensions;
using GroundZero.API.Middleware;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using QuestPDF.Infrastructure;

// Load .env file
Env.Load(Path.Combine(Directory.GetCurrentDirectory(), "..", "..", ".env"));

// QuestPDF Community License
QuestPDF.Settings.License = LicenseType.Community;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddApplicationServices();
builder.Services.AddInfrastructureServices();
builder.Services.AddJwtAuthentication();
builder.Services.AddSwaggerServices();

var app = builder.Build();

// Apply migrations and seed data
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    await context.Database.MigrateAsync();
    await DataSeeder.SeedAsync(context);
}

app.UseMiddleware<ExceptionHandlingMiddleware>();

app.UseSwagger();
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "GroundZero API v1");
    options.RoutePrefix = string.Empty;
});

app.UseHttpsRedirection();

// Serve uploaded files
var storagePath = Environment.GetEnvironmentVariable("FILE_STORAGE_PATH") ?? "./uploads";
var uploadsPath = Path.GetFullPath(storagePath);
Directory.CreateDirectory(uploadsPath);
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(uploadsPath),
    RequestPath = ""
});

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();
