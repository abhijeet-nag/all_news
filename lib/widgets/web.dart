import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';

class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  String url = Get.arguments;

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  InAppWebViewController? _webViewController;

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                  child: progress < 1.0
                      ? Center(child: LinearProgressIndicator(value: progress))
                      : Container()),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(url), method: url),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
