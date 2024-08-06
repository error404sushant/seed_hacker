import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: webView(),
    );
  }



  //region WebView
Widget webView(){
  final WebViewController controller =
  WebViewController.fromPlatformCreationParams(
      const PlatformWebViewControllerCreationParams());
  controller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(widget.url));
    return WebViewWidget(
        controller:controller
    );

    // return InAppWebView(
    //   initialUrlRequest: URLRequest(url: WebUri("https://google.com")),
    //
    //   //Progress
    //   onProgressChanged: (webViewController,progress){
    //     // appWebViewBloc.pageLoadingCtrl.sink.add(progress);
    //   },
    //
    // );
}
//endregion




}
