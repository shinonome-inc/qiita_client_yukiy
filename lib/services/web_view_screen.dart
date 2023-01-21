import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 730,
      width: 375,
      child: WebView(
        initialUrl: "https://qiita.com/",
        onPageFinished: (_) {
          print('Finished!');
        },
        onWebResourceError: (error) {
          print(error.description);
        },
      ),
    );
  }
}
