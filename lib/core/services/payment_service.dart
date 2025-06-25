import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymobService {
  static const String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeU9EazRNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5qd3hYTEpYWWYwOHYwS09uREpKWmRNbkNDZ3VVWUpEbkFrUUxRdzZmMzhvQzBkODN0U1J3UzBZOGkxdTlieDFKamlvbGc1clRSNGlVekk0SWpQRGpHZw==';

  static const String authUrl = "https://accept.paymob.com/api/auth/tokens";
  static const String orderUrl =
      "https://accept.paymob.com/api/ecommerce/orders";
  static const String paymentUrl =
      "https://accept.paymob.com/api/acceptance/payment_keys";

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
        // "integration_id": "5006145",
        "integration_id": "5164115",
      }),
    );

    if (response.statusCode == 201) {
      print('payment key: ${jsonDecode(response.body)["token"]}');
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception("Failed to get payment key");
    }
  }

  // static Future<String> payWithWallet(String paymentToken, String phone) async {
  //   final response = await http.post(
  //     Uri.parse('https://accept.paymob.com/api/acceptance/payments/pay'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       "source": {"identifier": phone, "subtype": "WALLET"},
  //       "payment_token": paymentToken,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     print('Payment response: $data');

  //     if (data['redirect_url'] != null) {
  //       print(data['redirect_url']);
  //       return data['redirect_url'];
  //     }

  //     return "تم الطلب بنجاح بدون redirect.";
  //   } else {
  //     print("Error: ${response.body}");
  //     throw Exception("Failed to pay with wallet");
  //   }
  // }
}

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay with Paymob")),
      body: WebViewWidget(controller: _controller),
    );
  }
}


/*
                      final authKey = await PaymobService.getAuthToken();
                      final orderId = await PaymobService.createOrder(
                        authKey,
                        500,
                      );
                      final paymentKey = await PaymobService.getPaymentKey(
                        authKey,
                        orderId,
                        500,
                      );
                      String paymentUrl =
                          "https://accept.paymob.com/api/acceptance/iframes/905872?payment_token=$paymentKey";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentWebView(paymentUrl: paymentUrl),
                        ),
                      );
                      */