import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
class PaymobService {
  static const String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeU9EazRNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5qd3hYTEpYWWYwOHYwS09uREpKWmRNbkNDZ3VVWUpEbkFrUUxRdzZmMzhvQzBkODN0U1J3UzBZOGkxdTlieDFKamlvbGc1clRSNGlVekk0SWpQRGpHZw==';

  static const String authUrl = "https://accept.paymob.com/api/auth/tokens";
  static const String orderUrl =
      "https://accept.paymob.com/api/ecommerce/orders";
  static const String paymentUrl =
      "https://accept.paymob.com/api/acceptance/payment_keys";

  // 1️⃣ احصل على التوكن (Authentication)
  static Future<String> getAuthToken() async {
    final response = await http.post(
      Uri.parse(authUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"api_key": apiKey}),
    );

    if (response.statusCode == 201) {
      print('token: ${jsonDecode(response.body)["token"]}');
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception("Failed to authenticate with Paymob");
    }
  }

  // 2️⃣ إنشاء الطلب (Order)
  static Future<int> createOrder(String authToken, int amount) async {
    final response = await http.post(
      Uri.parse(orderUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken",
      },
      body: jsonEncode({
        "auth_token": authToken,
        "amount_cents": amount.toString(),
        "currency": "EGP",
        "delivery_needed": false,
        "items": [],
      }),
    );

    if (response.statusCode == 201) {
      print('order id: ${jsonDecode(response.body)["id"]}');
      return jsonDecode(response.body)["id"];
    } else {
      throw Exception("Failed to create order");
    }
  }

  // 3️⃣ الحصول على رابط الدفع
  static Future<String> getPaymentKey(
    String authToken,
    int orderId,
    int amount,
  ) async {
    final response = await http.post(
      Uri.parse(paymentUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken",
      },
      body: jsonEncode({
        "auth_token": authToken,
        "amount_cents": amount.toString(),
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": {
          "first_name": "Waleed",
          "last_name": "Mohamed",
          "email": "waleedsefan24@gmail.com",
          "phone_number": "01029673915",
          "country": "EG",
          "city": "Cairo",
          "street": "Tahrir St.",
          "building": "123",
          "apartment": "123",
          "floor": "12",
        },
        "currency": "EGP",
        "integration_id": "5006145",
      }),
    );

    if (response.statusCode == 201) {
      print('payment key: ${jsonDecode(response.body)["token"]}');
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception("Failed to get payment key");
    }
  }
}

class PaymobPaymentScreen extends StatefulWidget {
  final String iframeUrl;

  const PaymobPaymentScreen({required this.iframeUrl});

  @override
  State<PaymobPaymentScreen> createState() => _PaymobPaymentScreenState();
}

class _PaymobPaymentScreenState extends State<PaymobPaymentScreen> {
  late final WebViewController _controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            if (_navigated) return; // منع التنقل أكثر من مرة
            print("📄 Page Loaded: $url");

            final htmlContent = await _controller.runJavaScriptReturningResult(
              "document.body.innerText",
            );

            print("📄 HTML content: $htmlContent");

            final content = htmlContent.toString().toLowerCase();

            if (content.contains("approved")) {
              _navigated = true;

              final uri = Uri.tryParse(url);
              final transactionId = uri?.queryParameters['id'] ?? 'N/A';
              print(
                '----------------------------------------------------------',
              );
              print(uri?.queryParameters.toString());

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => InvoiceScreen(transactionId: transactionId),
                ),
              );
            }

            if (content.contains("failed") || content.contains("declined")) {
              _navigated = true;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PaymentFailedScreen()),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.iframeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay")),
      body: WebViewWidget(controller: _controller),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  final String transactionId;

  const InvoiceScreen({required this.transactionId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text('Payment Successful!', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            Text('Transaction ID: $transactionId'),
          ],
        ),
      ),
    );
  }
}

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Failed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.error, color: Colors.red, size: 80),
            SizedBox(height: 16),
            Text('Payment Failed!', style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
