// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/infrastructure/webapp_authenticator.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({
    Key? key,
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
  }) : super(key: key);

  static const backButtonKey = ValueKey('backButton');

  final Uri authorizationUrl;
  final void Function(Uri redirectUri) onAuthorizationCodeRedirectAttempt;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(widget.authorizationUrl)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest navReq) {
            if (navReq.url.startsWith(WebAppAuthenticator.redirectUrl().toString())) {
              widget.onAuthorizationCodeRedirectAttempt(
                Uri.parse(navReq.url),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..clearCache();

    WebViewCookieManager().clearCookies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: AppBar(
            //     title: const Text(''), // You can add title here
            //     leading: IconButton(
            //       key: AuthorizationPage.backButtonKey,
            //       icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            //       onPressed: () => Navigator.of(context).pop(),
            //     ),
            //     backgroundColor: Colors.white.withOpacity(0.1), //You can make this transparent
            //     elevation: 0, //No shadow
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
