using GroundZero.Application.IServices;
using Stripe;

namespace GroundZero.Infrastructure.Services;

public class StripeService : IStripeService
{
    public StripeService()
    {
        StripeConfiguration.ApiKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY")
            ?? throw new InvalidOperationException("STRIPE_SECRET_KEY is not configured.");
    }

    public async Task<(string PaymentIntentId, string ClientSecret)> CreatePaymentIntentAsync(
        decimal amount, string currency = "bam")
    {
        var options = new PaymentIntentCreateOptions
        {
            Amount = (long)(amount * 100), // Stripe uses smallest currency unit (cents/fenings)
            Currency = currency,
            PaymentMethodTypes = new List<string> { "card" }
        };

        var service = new PaymentIntentService();
        var paymentIntent = await service.CreateAsync(options);

        return (paymentIntent.Id, paymentIntent.ClientSecret);
    }
}
