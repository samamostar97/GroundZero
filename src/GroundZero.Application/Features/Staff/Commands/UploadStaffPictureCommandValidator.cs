using FluentValidation;
using GroundZero.Application.Common;

namespace GroundZero.Application.Features.Staff.Commands;

public class UploadStaffPictureCommandValidator : AbstractValidator<UploadStaffPictureCommand>
{
    public UploadStaffPictureCommandValidator()
    {
        RuleFor(x => x.FileSize)
            .GreaterThan(0).WithMessage("Fajl je obavezan.")
            .LessThanOrEqualTo(FileValidationHelper.MaxImageSize)
            .WithMessage("Maksimalna veličina slike je 5 MB.");

        RuleFor(x => x.FileName)
            .Must(fileName =>
            {
                var ext = Path.GetExtension(fileName)?.ToLower();
                return FileValidationHelper.AllowedImageExtensions.Contains(ext);
            })
            .When(x => x.FileSize > 0)
            .WithMessage("Dozvoljeni formati slike su: jpg, jpeg, png, webp.");
    }
}
