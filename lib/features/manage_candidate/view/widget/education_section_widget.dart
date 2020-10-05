import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/edu_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/method_extension.dart';

class EducationSectionWidget extends StatelessWidget {
  final List<EduInfo> eduInfo;


  EducationSectionWidget(this.eduInfo);

  @override
  Widget build(BuildContext context) {

    return UserInfoListItem(
      icon: FontAwesomeIcons.university,
      label: StringResources.educationsText,
      children: List.generate(eduInfo.length, (int i) {
        return EducationsListItem(
          eduInfoModel: eduInfo[i],
        );
      }),
    );
  }
}



class EducationsListItem extends StatefulWidget {
  final EduInfo eduInfoModel;

  EducationsListItem(
      {@required this.eduInfoModel,});

  @override
  _EducationsListItemState createState() => _EducationsListItemState();
}

class _EducationsListItemState extends State<EducationsListItem> {
  bool expanded = false;
  bool expandable(){
    if(widget.eduInfoModel.description.htmlToNotusDocument.toPlainText().length>1
      || widget.eduInfoModel.cgpa!=''
      || widget.eduInfoModel.majorText!=''
//      || widget.eduInfoModel.educationLevel != ''
    ){return true;}else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget _item(
        {@required BuildContext context,
          @required String label,
          @required String value,
          @required Key valueKey}) {

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text("$label: ",style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(child: Text("${value ?? ""}", key: valueKey,)),
          ],),
      );
    }
    
    var backgroundColor = Theme.of(context).backgroundColor;
    String graduationDateText = widget.eduInfoModel.graduationDate != null
        ? DateFormatUtil.formatDate(widget.eduInfoModel.graduationDate)
        : StringResources.ongoingText;
    String date =
        "${widget.eduInfoModel.enrolledDate != null ? DateFormatUtil.formatDate(widget.eduInfoModel.enrolledDate) : ""} - $graduationDateText";
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 5),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.eduInfoModel?.institutionObj?.image??"",
                height: 61,
                width: 61,
                placeholder: (v,i)=>    Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.university,
                      size: 45,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.eduInfoModel.institutionObj?.name ??
                          widget.eduInfoModel.institutionText ??
                          "",style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${widget.eduInfoModel?.degreeText??widget.eduInfoModel.degreeText??""}",style: TextStyle(fontSize: 13),),
                        Text(
                          date,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          expandable()?ExpansionTile(
            title: null,
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            tilePadding: EdgeInsets.zero,
            children: [
              widget.eduInfoModel.educationLevel!=null?Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(widget.eduInfoModel.educationLevel),
              ):SizedBox(),
              if(widget.eduInfoModel.majorText!='')_item(context: context, label: StringResources.majorText, value: widget.eduInfoModel.majorText, valueKey: null),
              if(widget.eduInfoModel.cgpa!='')_item(context: context, label: StringResources.cgpaText, value: widget.eduInfoModel.cgpa, valueKey: null),
              widget.eduInfoModel.description.htmlToNotusDocument.toPlainText().length>1?
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: HtmlWidget(widget.eduInfoModel.description),
              ):SizedBox(),
            ],
          ):SizedBox(height: 3,),
        ],
      ),
    );
  }
}
