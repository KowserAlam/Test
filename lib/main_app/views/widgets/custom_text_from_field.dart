import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';

class CustomTextFormField extends StatelessWidget {
  final Function validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode focusNode;
  final bool autofocus;
  final bool enabled;
  final bool autovalidate;
  final bool readOnly;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final Widget prefix;
  final Function onChanged;
  final   int maxLength;
  final GestureTapCallback onTap;

  const CustomTextFormField({
    this.readOnly= false,
    this.enabled = true,
    this.maxLength,
    this.validator,
    this.prefix,
    this.onChanged,
    this.textInputAction,
    this.autovalidate = false,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.minLines,
    this.onTap,
    this.keyboardType,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.maxLines = 1,

  });

  @override
  Widget build(BuildContext context) {

    FocusScopeNode currentFocus = FocusScope.of(context);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if(labelText != null)
        Text("  ${labelText ?? ""}",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
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
          child: TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            maxLength: maxLength,
            minLines: minLines,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            autofocus: autofocus,
            focusNode: focusNode,
            maxLines: maxLines,
            autovalidate: autovalidate,
            keyboardType: keyboardType,
            validator: validator,
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              prefix: prefix,
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
//        errorText != null ? Text('') : SizedBox(),
      ],
    );
  }
}
