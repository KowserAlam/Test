import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/pge_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.faqWeb}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.faqText),
      ),
      body: PgeViewWidget(url: url,),
    );
  }
}
