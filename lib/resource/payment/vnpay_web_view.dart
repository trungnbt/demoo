import 'package:flutter/material.dart';
import 'package:webspc/Api_service/payment_service.dart';
import 'package:webspc/DTO/payment.dart';
import 'package:webspc/resource/Profile/spc_wallet_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPaymentWebViewScreen extends StatefulWidget {
  const VnPaymentWebViewScreen({super.key, required this.url});
  final String url;
  @override
  State<VnPaymentWebViewScreen> createState() => _VnPaymentWebViewScreenState();
}

class _VnPaymentWebViewScreenState extends State<VnPaymentWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            // Check if request url contains "http://spcapp.net/returnUrl"
            if (request.url.contains("http://spcapp.net/returnUrl")) {
              // If the payment is successful, the url will contain the query string "vnp_ResponseCode=00"
              if (request.url.contains('vnp_ResponseCode=00')) {
                double amount = double.parse(
                        request.url.split('vnp_Amount=')[1].split('&')[0]) /
                    100;
                // Update wallet
                await PaymentService.addPayment(
                  amount: amount,
                  purpose: 'Top up',
                );
                // Show a dialog to notify the user that the payment is successful.
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Nạp tiền thành công'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SPCWalletScreen(context),
                          //   ),
                          // );
                          Navigator.pop(context, true);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return NavigationDecision.prevent;
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Nạp tiền thất bại'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return NavigationDecision.prevent;
              }
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: controller));
  }
}
