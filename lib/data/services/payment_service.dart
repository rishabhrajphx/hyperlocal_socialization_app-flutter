import 'package:stripe_platform_interface/stripe_platform_interface.dart';

class PaymentService {
  final Stripe _stripe;
  
  PaymentService({Stripe? stripe})
      : _stripe = stripe ?? Stripe.instance;

  Future<PaymentIntent> createPaymentIntent(double amount) async {
    try {
      // Convert amount to cents/smallest currency unit
      final amountInCents = (amount * 100).toInt();
      
      // Create payment intent
      final paymentIntent = await _stripe.createPaymentIntent({
        'amount': amountInCents.toString(),
        'currency': 'usd',
        'payment_method_types': ['card'],
      });
      
      return paymentIntent;
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }
  
  Future<void> handleApplePay() async {
    try {
      // Check if Apple Pay is available
      final isAvailable = await _stripe.isApplePaySupported();
      if (!isAvailable) {
        throw Exception('Apple Pay is not available on this device');
      }

      // Present Apple Pay sheet
      final paymentResult = await _stripe.presentApplePay(
        ApplePayPresentParams(
          cartItems: [
            ApplePayCartItem(
              label: 'Your Product/Service',
              amount: '10.99',
            ),
          ],
          country: 'US',
          currency: 'USD',
        ),
      );

      // Handle the payment result
      if (paymentResult.status == PaymentStatus.succeeded) {
        // Payment successful
        return;
      } else {
        throw Exception('Payment failed: ${paymentResult.error}');
      }
    } catch (e) {
      throw Exception('Apple Pay failed: $e');
    }
  }
} 