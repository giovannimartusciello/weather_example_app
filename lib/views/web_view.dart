import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  static const routeName = '/webView';

  const WebView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            mediaPlaybackRequiresUserGesture: false,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ));
      return Scaffold(
          body: InAppWebView(
              key: GlobalKey(),
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature&lat=51&lon=0&zoom=10")),
              initialOptions: options,
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.home),
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Scaffold(
          body: const UiKitView(viewType: 'webview'),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.home),
          ));
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the web view plugin');
  }
}
