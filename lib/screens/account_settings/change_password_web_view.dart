import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotspeak_mobile/misc/auth_constants.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChangePasswordWebView extends StatefulWidget {
  const ChangePasswordWebView({super.key});

  @override
  State<ChangePasswordWebView> createState() => _ChangePasswordWebViewState();
}

class _ChangePasswordWebViewState extends State<ChangePasswordWebView> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Check if the request is the redirect URI
            if (request.url.startsWith(kCloseWebViewUrl)) {
              showSuccessToast();

              // Close the WebView and navigate back
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(kPasswordResetUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Future<void> showSuccessToast() async {
    await Fluttertoast.showToast(
      msg: 'Hasło zostało prawidłowo zmienione',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: CustomColors.grey1,
      textColor: CustomColors.grey6,
    );
  }
}
