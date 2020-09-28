import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobxprss_company/features/dashboard/values.dart';
import 'package:jobxprss_company/main_app/contact_us_screen.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/about_us_screen.dart';
import 'package:jobxprss_company/main_app/views/contact_us_screen.dart';
import 'package:jobxprss_company/main_app/views/faq_screen.dart';


class OtherScreensWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _navigateTo(Widget page) {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (BuildContext context) {
        return page;
      }));
    }

    return Column(
      children: [
        Row(children: [
          Text(StringResources.moreInfoTitleText,
            style: DashboardValues.dashboardSectionLabelStyle,
          ),
        ],),
        DashboardValues.sizedBoxBetweenSectionLabel,
        Row(
          children: [
            Expanded(
              child: item(
                key: Key('dashBoardFAQTile'),
                icon: FontAwesomeIcons.questionCircle,
                label: StringResources.faqText,
                onPressed: () {
                  _navigateTo(FAQScreen());
                },
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
                child: item(
                  key: Key('dashBoardContactUsTile'),
              icon: FontAwesomeIcons.at,
              label: StringResources.contactUsText,
              onPressed: () {
                _navigateTo(ContactUsScreen());
              },
            )),
            SizedBox(width: 8,),
            Expanded(
                child: item(
                  key: Key('dashBoardAboutUsTile'),
              icon: FontAwesomeIcons.infoCircle,
              label: StringResources.aboutUsText,
              onPressed: () {
                _navigateTo(AboutUsScreen());
              },
            )),
          ],
        ),
        SizedBox(height: 14,),
      ],
    );
  }

  Widget item({
    @required IconData icon,
    @required String label,
    @required VoidCallback onPressed,
    Key key
  }) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var deviceWidth = MediaQuery.of(context).size.width;

        double iconSize = deviceWidth * .183;
        double textFontSize =  constraints.maxWidth/8;
        double boxHeight = iconSize * 1.1;
        return Material(
          elevation: 2,
          color: Theme.of(context).backgroundColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

          child: Material(
            key: key,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Theme.of(context).primaryColor.withOpacity(0.5),

            child: InkWell(
              onTap: onPressed,
              child: Container(
                height: boxHeight,
                child: Stack(
                  children: [
                    Center(
                        child: Icon(
                      icon,
                      color: Colors.grey.withOpacity(0.15),
                      size: iconSize,
                    )),
                    Center(
                      child: Text(
                        label ?? "",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: textFontSize,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
