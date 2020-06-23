import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PgeViewWidget extends StatefulWidget {
  final String url;

  PgeViewWidget({Key key, @required this.url}) : super(key: key);

  @override
  _PgeViewWidgetState createState() => _PgeViewWidgetState();
}

class _PgeViewWidgetState extends State<PgeViewWidget> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url, javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (v) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading ? Center(child: Loader()) : Container(),
      ],
    );
  }
}