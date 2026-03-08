namespace GroundZero.Domain.Entities;

public class PasswordResetToken : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public string Code { get; set; } = string.Empty;
    public DateTime ExpiresAt { get; set; }
    public bool IsUsed { get; set; }
}
