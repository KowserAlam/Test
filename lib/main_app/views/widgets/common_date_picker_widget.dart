import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';

class CommonDatePickerWidget extends StatefulWidget {
  final String label;
  final String errorText;
  final DateTime date;
  final Function(DateTime) onDateTimeChanged;
  final Function onTapDateClear;
  final DateTime minDate;
  final DateTime maxDate;


  const CommonDatePickerWidget(
      {@required this.label,
      @required this.date,
      @required this.onDateTimeChanged,
      this.onTapDateClear,
      this.maxDate,
      this.minDate,
      this.errorText});

  @override
  _CommonDatePickerWidgetState createState() => _CommonDatePickerWidgetState();
}

class _CommonDatePickerWidgetState extends State<CommonDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          widget.label ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus?.unfocus();
            _showCupertinoDatePicker(context);
//            Theme.of(context).platform == TargetPlatform.iOS
//                ?
//            _showCupertinoDatePicker(context):
//            _showDatePicker(context);
//            _selectDateAndroid(context);
          },
          child: Container(
            height: 50,
            width: double.infinity,
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.date != null
                        ? DateFormatUtil.formatDate(widget.date)
                        : StringResources.chooseDateText,
                  ),
                  if (widget.onTapDateClear != null)
                    widget.date != null
                        ? InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.close),
                            ),
                            onTap: widget.onTapDateClear,
                          )
                        : SizedBox(),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.errorText,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  _showCupertinoDatePicker(context) {
    var _miniDate =
        widget.maxDate ?? DateTime.now().subtract(Duration(days: 360 * 100));
    var _maxDate = widget.minDate ?? DateTime.now().add(Duration(days: 360 * 10));

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                            brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          maximumDate: _maxDate,
                          minimumDate: _miniDate,
                          initialDateTime: widget.date ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v) {
                            if (v.year >= _miniDate.year &&
                                v.year <= _maxDate.year) {
                              widget.onDateTimeChanged(v);
                            }
                          },
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          widget.onDateTimeChanged(widget.date ?? DateTime.now());
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

 _selectDateAndroid(BuildContext context) async {
    var _miniDate =
        widget.maxDate ?? DateTime.now().subtract(Duration(days: 360 * 100));
    var _maxDate = widget.minDate ?? DateTime.now().add(Duration(days: 360 * 10));
    showDatePicker(
      firstDate: _miniDate,
      initialDate: widget.date??DateTime.now(),
      lastDate: _maxDate,
      context: context,
    ).then((value) {
      widget.onDateTimeChanged(value);

    });

  }

  _showDatePicker(context) {
    var _miniDate =
        widget.maxDate ?? DateTime.now().subtract(Duration(days: 360 * 100));
    var _maxDate = widget.minDate ?? DateTime.now().add(Duration(days: 360 * 10));

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CalendarDatePicker(
                        lastDate: _maxDate,
                        firstDate: _miniDate,
                        initialDate: widget.date ?? DateTime.now(),
                        onDateChanged: (v) {
                          if (v.year >= _miniDate.year &&
                              v.year <= _maxDate.year) {
                            widget.onDateTimeChanged(v);
                          }
                        },
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          widget.onDateTimeChanged(widget.date ?? DateTime.now());
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
