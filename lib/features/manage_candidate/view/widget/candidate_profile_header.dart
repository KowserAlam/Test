import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/models/candidate_model.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/method_extension.dart';

class UserProfileHeader extends StatelessWidget {
  final CandidateModel candidateModel;

  UserProfileHeader(this.candidateModel);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var profileHeaderBackgroundColor = Color(0xff273F55);
    var profileHeaderFontColor = Colors.white;
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

    Widget profileImageWidget() => Container(
          margin: EdgeInsets.only(bottom: 15, top: 8),
          // height: 65,
          // width: 65,

          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: CommonStyle.boxShadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              height: 65,
              width: 65,
              fit: BoxFit.cover,
              imageUrl: candidateModel.personalInfo?.profileImage ?? "",
              placeholder: (context, _) => Image.asset(
                kDefaultUserImageAsset,
                fit: BoxFit.cover,
                height: 65,
                width: 65,
              ),
            ),
          ),
        );
    Widget displayNameWidget() => Text(
          candidateModel.personalInfo.fullName ?? "",
          key: Key('myProfileHeaderName'),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: profileHeaderFontColor),
        );
    Widget socialIconsWidgets = Material(
      type: MaterialType.transparency,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              var username = candidateModel.personalInfo.facebookId;
              if (username.isNotEmptyOrNotNull) {
//                    UrlLauncherHelper.launchFacebookUrl(username);
                UrlLauncherHelper.launchUrl(
                    "https://" + StringResources.facebookBaseUrl + username);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 25,
                width: 25,
                child: Material(
                  color: AppTheme.facebookColor,
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
//            SizedBox(
//              width: 8,
//            ),
          InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              var link = candidateModel.personalInfo.linkedinId;
              if (link != null) {
                if (link.isNotEmpty)
                  UrlLauncherHelper.launchUrl(
                      "https://" + StringResources.linkedBaseUrl + link);
              }
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: AppTheme.linkedInColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                FontAwesomeIcons.linkedinIn,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
//            SizedBox(width: 8),
          InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              var link = candidateModel.personalInfo.twitterId;
              if (link != null) {
                if (link.isNotEmpty)
                  UrlLauncherHelper.launchUrl(
                      "https://" + StringResources.twitterBaeUrl + link);
              }
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: AppTheme.twitterColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
    Widget userLocationWidget() =>
        candidateModel?.personalInfo?.currentLocation == null
            ? SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 10,
                    color: profileHeaderFontColor,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    candidateModel.personalInfo.currentLocation ?? "",
                    key: Key('myProfileHeaderLocation'),
                    style: TextStyle(
                        color: profileHeaderFontColor,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              );

    Widget userMobileWidget() {
      if (candidateModel.personalInfo.phone == null) {
        return SizedBox();
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.phone_android,
            size: 10,
            color: profileHeaderFontColor,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            candidateModel.personalInfo.phone ?? "",
            key: Key('myProfileHeaderPhone'),
            style: TextStyle(
                color: profileHeaderFontColor, fontWeight: FontWeight.w100),
          ),
        ],
      );
    }

    Widget emailWidget() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail,
              size: 10,
              color: profileHeaderFontColor,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              candidateModel.personalInfo.email ?? "",
              key: Key('myProfileHeaderEmail'),
              style: TextStyle(
                color: profileHeaderFontColor,
              ),
            ),
          ],
        );
    var position = candidateModel.personalInfo.currentDesignation;
    var company = candidateModel.personalInfo.currentCompany;
    Widget designationWidget() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            position == null
                ? SizedBox()
                : Text(
                    position,
                    key: Key('myProfileHeaderDesignation'),
                    style: TextStyle(
                        color: profileHeaderFontColor,
                        fontWeight: FontWeight.w100),
                  ),
            SizedBox(
              height: 5,
            ),
            company == null
                ? SizedBox()
                : Text(
                    company,
                    key: Key('myProfileHeaderCompany'),
                    style: TextStyle(
                        color: profileHeaderFontColor,
                        fontWeight: FontWeight.w100),
                  ),
          ],
        );
    Widget aboutMeWidget = UserInfoListItem(
      icon: FontAwesomeIcons.infoCircle,
      label: StringResources.aboutMeText,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: CommonStyle.boxShadow,
          ),
          // margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              candidateModel.personalInfo.aboutMe ?? "",
              key: Key('myProfileHeaderDescription'),
            ),
          ),
        ),
      ],
    );
    return // profile header
        Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: profileHeaderBackgroundColor,
            image: DecorationImage(
              image: AssetImage(kUserProfileCoverImageAsset),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
            ),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileImageWidget(),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        displayNameWidget(),
                        SizedBox(height: 3),
                        designationWidget(),
                        SizedBox(height: 3),

//                                SizedBox(height: 3),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              socialIconsWidgets,
              SizedBox(height: 5),
              userMobileWidget(),
              SizedBox(height: 5),
              emailWidget(),
              SizedBox(height: 5),
              userLocationWidget(),
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: aboutMeWidget,
        ),
      ],
    );
  }
}
