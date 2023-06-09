import 'package:days_21/Screen/Payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGetWayScreen extends StatelessWidget {
  final String bankGateWayUrl;
  final String name;
  final String image;
  const PaymentGetWayScreen(
      {Key? key,
      required this.bankGateWayUrl,
      required this.name,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            final uri = Uri.parse(url);
            debugPrint(uri.pathSegments.toString());
            final payment = uri.queryParameters["status"]!; //failed
            if (payment.isNotEmpty && payment == 'failed') {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    image: image,
                    name: name,
                    orderId: 123,
                    status: 0,
                  ),
                ),
              );
            } else if (payment.isNotEmpty && payment == 'ok') {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    image: image,
                    name: name,
                    orderId: 123,
                    status: 1,
                  ),
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(bankGateWayUrl));
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
