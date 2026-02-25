using GroundZero.Application.IServices;

namespace GroundZero.Infrastructure.Services;

public class DateTimeService : IDateTimeService
{
    public DateTime Now => DateTime.UtcNow;
}
