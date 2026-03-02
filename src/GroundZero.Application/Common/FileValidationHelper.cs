namespace GroundZero.Application.Common;

public static class FileValidationHelper
{
    public static readonly string[] AllowedImageExtensions = { ".jpg", ".jpeg", ".png", ".webp" };
    public const long MaxImageSize = 5 * 1024 * 1024; // 5 MB
}
