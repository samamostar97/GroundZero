namespace GroundZero.Application.IServices;

public interface IStripeService
{
    Task<(string PaymentIntentId, string ClientSecret)> CreatePaymentIntentAsync(decimal amount, string currency = "bam");
}
