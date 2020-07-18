import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
export 'package:flutter_summernote/flutter_summernote.dart';

class CustomTextFieldRichHtml extends StatelessWidget {
  final String labelText;
  final String hint;
  final String value;
  final double height;
  final String customToolbar;
  final editingKey;

  CustomTextFieldRichHtml({
     Key key,
    this.height = 200,
    this.labelText,
    this.value,
    this.hint,
    this.customToolbar,
    this.editingKey,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelText != null)
          Text("${labelText ?? ""}",
              style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
              BoxShadow(
                  color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: FlutterSummernote(
            value: value,
            height: height,
            hint: hint ?? "",
            showBottomBar: false,
            key: editingKey,
            customToolbar: """
                         [
                           ['style', ['bold', 'italic', 'underline', 'clear']],
                            ['para', ['ul', 'ol', 'paragraph']],
                            ['height', ['height']],
                         ]
                       """,
          ),
        ),
//        errorText != null ? Text('') : SizedBox(),
      ],
    );
  }
}
