import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/experience_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/method_extension.dart';

class ExperienceSectionWidget extends StatelessWidget {

  final List<ExperienceInfo> experienceInfo;


  ExperienceSectionWidget(this.experienceInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(

      icon: FontAwesomeIcons.globeEurope,
      label: StringResources.workExperienceText,

      children: List.generate(experienceInfo.length, (int index) {
        var exp = experienceInfo[index];
        return ExperienceListItem(
          experienceInfoModel: exp);
      }),
    );

  }
}

class ExperienceListItem extends StatefulWidget {
  final ExperienceInfo experienceInfoModel;

  ExperienceListItem(
      {this.experienceInfoModel});

  @override
  _ExperienceListItemState createState() => _ExperienceListItemState();
}

class _ExperienceListItemState extends State<ExperienceListItem> {
  bool expanded = false;
  bool expandable(){
    if(widget.experienceInfoModel.description.htmlToNotusDocument.toPlainText().length>1){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;

    String startDate = widget.experienceInfoModel.startDate != null
        ? "${DateFormatUtil().dateFormat1(widget.experienceInfoModel.startDate)} "
        : "";
    String date = "$startDate"
        "- ${widget.experienceInfoModel.endDate == null ? "Ongoing" : DateFormatUtil().dateFormat1(widget.experienceInfoModel.endDate)}";

    return AnimatedContainer(
      duration: Duration(milliseconds: 5000),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                height: 55,
                width: 55,
                fit: BoxFit.cover,
                placeholder: (context, _) => Image.asset(
                  kCompanyImagePlaceholder,
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                ),
                imageUrl: widget.experienceInfoModel.companyProfilePic ?? "",
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.experienceInfoModel.companyNameText ?? "",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.experienceInfoModel.designation ?? "",),
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
          SizedBox(height: 8,),
          expanded?HtmlWidget(widget.experienceInfoModel.description):SizedBox(),
          expandable()?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    expanded = !expanded;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: expanded?Colors.orange:Colors.transparent,
                        border: Border.all(color: expanded?Colors.deepOrangeAccent:Colors.grey[300], width: 1)
                    ),
                    child: Icon(expanded?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down, color: expanded?Colors.white:Colors.black,)),
              )
            ],
          ):SizedBox(),
        ],
      ),
    );
  }
}
