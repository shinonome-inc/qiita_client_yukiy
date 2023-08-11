import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/top_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  double _webViewHeight = 0;
  late String article;

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController.runJavascriptReturningResult(
          "document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: _webViewHeight,
            child: WebView(
              initialUrl: Uri.parse(widget.url).toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                _webViewController = controller;
              },
              onPageFinished: (String url) {
                Uri uri;
                uri = Uri.parse(url);
                _onPageFinished(context, url);
                print(url);
                if (url.contains(
                    'https://qiita.com/settings/applications?code=')) {
                  String? code = uri.queryParameters['code'];
                  print(uri.queryParameters['code']);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => TopPage(
                        code: code,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
