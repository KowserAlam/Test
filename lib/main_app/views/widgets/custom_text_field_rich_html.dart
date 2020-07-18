import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
export 'package:flutter_summernote/flutter_summernote.dart';
import 'package:jobxprss_company/method_extension.dart';
class CustomTextFieldRichHtml extends StatefulWidget {
  final String labelText;
  final String hint;
  final String value;
  final double height;
  final String customToolbar;
  final bool required;
  final Function(String value) onDone;

  CustomTextFieldRichHtml({
    Key key,
    this.height = 400,
    this.labelText,
    this.value,
    this.required = false,
    this.hint,
    this.onDone,
    this.customToolbar,
  }) : super(key: key);

  @override
  _CustomTextFieldRichHtmlState createState() =>
      _CustomTextFieldRichHtmlState(this.value);
}

class _CustomTextFieldRichHtmlState extends State<CustomTextFieldRichHtml> {
  final GlobalKey<FlutterSummernoteState> _editingKey = GlobalKey();
  String value;


  _CustomTextFieldRichHtmlState(this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.labelText != null)
          Row(
            children: [
              Flexible(
                child: Text("  ${widget.labelText ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (widget.required)
                Text(
                  " *",
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 100,

          ),
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
          child: InkWell(
            onTap: () {
              _openSelectDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
               value ?? "",
              ),
            ),
          ),
        ),
//        errorText != null ? Text('') : SizedBox(),
      ],
    );
  }

  _openSelectDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: const Color(0x80000000),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          content: FlutterSummernote(
            value: value,
            height: widget.height,
            hint: widget.hint ?? "",
            showBottomBar: false,
            key: _editingKey,
            customToolbar: """
                         [
                           ['style', ['bold', 'italic', 'underline', 'clear']],
                            ['para', ['ul', 'ol', 'paragraph']],
                            ['height', ['height']],
                         ]
                       """,
          ),
          actions: [
            RaisedButton(
              onPressed: () async {

                _editingKey.currentState.getText().then((v) {
                  widget.onDone(v);
                  value = v;
                  if(this.mounted)
                  setState(() {});

                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus?.unfocus();
                });
                Navigator.pop(context);

              },
              child: Text(StringResources.doneText),
            )
          ],
        );
      },
    );
  }
}
