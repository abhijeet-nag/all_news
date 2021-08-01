import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: WebviewScaffold(
        url: url,
        appCacheEnabled: true,
        withZoom: true,
        ignoreSSLErrors: true,
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: 60,
          child: AdWidget(
            key: UniqueKey(),
            ad: AdmobServices.createBannerAd()..load(),
          ),
        ),
      ),
    );
  }
}
