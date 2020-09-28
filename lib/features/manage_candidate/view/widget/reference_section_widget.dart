import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/reference_data.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class ReferenceSection extends StatelessWidget {
  final List<ReferenceData> references;

  ReferenceSection(this.references);

  @override
  Widget build(BuildContext context) {


    return UserInfoListItem(
      icon: FontAwesomeIcons.bookReader,
      label: StringResources.referencesText,
      children: List.generate(references.length, (index) {
        var ref = references[index];
        return ReferencesListItemWidget(
          referenceData: ref,
        );
      }),
    );
}
}



class ReferencesListItemWidget extends StatefulWidget {
  final ReferenceData referenceData;
  const ReferencesListItemWidget({
    Key key,
    @required this.referenceData,
  }) : super(key: key);

  @override
  _ReferencesListItemWidgetState createState() =>
      _ReferencesListItemWidgetState();
}

class _ReferencesListItemWidgetState extends State<ReferencesListItemWidget> {
  bool isExpanded = false;
  int chLength = 150;

  @override
  Widget build(BuildContext context) {
    bool hasMoreText = widget.referenceData.description == null
        ? false
        : widget.referenceData.description.length > chLength;
    String text = (isExpanded || !hasMoreText)
        ? widget.referenceData?.description ?? ""
        : widget.referenceData?.description?.substring(0, chLength) ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
//                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  height: 55,
                  width: 55,
                  child: Icon(FontAwesomeIcons.user,size: 30,),
                ),
                Expanded(
//                  child: Text(
//                    text ?? "", key: Key('referenceTileDescription'+(widget.index+1).toString()),
//                  ),
                child: HtmlWidget(text),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            if (hasMoreText)
              InkWell(
                onTap: () {
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    isExpanded
                        ? StringResources.seeLessText
                        : StringResources.seeMoreText,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
