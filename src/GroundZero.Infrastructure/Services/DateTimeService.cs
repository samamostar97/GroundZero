using GroundZero.Application.Common.Interfaces;

namespace GroundZero.Infrastructure.Services;

public class DateTimeService : IDateTimeService
{
    public DateTime Now => DateTime.UtcNow;
}
