// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/infrastructure/webapp_authenticator.dart';

@RoutePage()
class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
    super.key,
  });

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
          // coverage:ignore-start

          /// Ignoring this from coverage because it's not possible to widget-test
          /// this block of code as the controller is not exposed to trigger this.
          ///
          /// Testing this is done in the integration tests.
          onNavigationRequest: (NavigationRequest navReq) {
            if (navReq.url.startsWith(WebAppAuthenticator.redirectUrl().toString())) {
              widget.onAuthorizationCodeRedirectAttempt(
                Uri.parse(navReq.url),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          // coverage:ignore-end
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
          ],
        ),
      ),
    );
  }
}
