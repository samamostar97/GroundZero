using GroundZero.Application.IServices;

namespace GroundZero.Infrastructure.Services;

public class FileService : IFileService
{
    private readonly string _storagePath;

    public FileService()
    {
        _storagePath = Environment.GetEnvironmentVariable("FILE_STORAGE_PATH") ?? "./uploads";
    }

    public async Task<string> UploadFileAsync(Stream fileStream, string fileName, string folder)
    {
        var folderPath = Path.Combine(_storagePath, folder);
        Directory.CreateDirectory(folderPath);

        var uniqueFileName = $"{Guid.NewGuid()}{Path.GetExtension(fileName)}";
        var filePath = Path.Combine(folderPath, uniqueFileName);

        using var outputStream = new FileStream(filePath, FileMode.Create);
        await fileStream.CopyToAsync(outputStream);

        return $"/{folder}/{uniqueFileName}";
    }

    public void DeleteFile(string filePath)
    {
        var fullPath = Path.Combine(_storagePath, filePath.TrimStart('/'));
        if (File.Exists(fullPath))
            File.Delete(fullPath);
    }
}
