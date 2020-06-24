import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class PostNewJobScreen extends StatefulWidget {
  @override
  _PostNewJobScreenState createState() => _PostNewJobScreenState();
}

class _PostNewJobScreenState extends State<PostNewJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(StringResources.postNewJobText),
    ));
  }
}
