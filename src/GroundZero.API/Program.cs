using DotNetEnv;
using GroundZero.API.Extensions;
using GroundZero.API.Middleware;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using QuestPDF.Infrastructure;

// Load .env file (skipped in Docker — env vars injected via docker-compose env_file)
var envPath = Path.Combine(Directory.GetCurrentDirectory(), "..", "..", ".env");
if (File.Exists(envPath))
    Env.Load(envPath);

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

// Copy seed images to uploads if missing (handles Docker volume mount)
var seedSource = Path.Combine(AppContext.BaseDirectory, "seed-images");
var seedDest = Path.Combine(uploadsPath, "seed");
if (Directory.Exists(seedSource))
{
    Directory.CreateDirectory(seedDest);
    foreach (var file in Directory.GetFiles(seedSource))
    {
        var dest = Path.Combine(seedDest, Path.GetFileName(file));
        if (!File.Exists(dest))
            File.Copy(file, dest);
    }
}
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(uploadsPath),
    RequestPath = ""
});

app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

app.Run();
