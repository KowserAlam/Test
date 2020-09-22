import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/company_edit_profile.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/profile_section_base.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/repositories/country_repository.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:jobxprss_company/main_app/views/widgets/show_location_on_map_widget.dart';
import 'package:provider/provider.dart';
import 'package:jobxprss_company/method_extension.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile();

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> with AfterLayoutMixin {
  final Widget sectionDivider = SizedBox(
    height: 1.5,
  );

  @override
  void afterFirstLayout(BuildContext context) {
    var vm = Provider.of<CompanyProfileViewModel>(context, listen: false);
    vm.getCompanyDetails();
  }

  errorWidget() {
    var vm = Provider.of<CompanyProfileViewModel>(context);
    switch (vm.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {
            return vm.refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.couldNotReachServer,
          onTap: () {
            return vm.refresh();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return vm.refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Styles
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    TextStyle headerTextStyle =
        new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sectionTitleFont =
        TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
    TextStyle descriptionFontStyleBold =
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];

// widgets

    var vm = Provider.of<CompanyProfileViewModel>(context);
    Company companyDetails = vm.company;

    /// show loading
    if (vm.showLoading) {
      return RefreshIndicator(
        onRefresh: vm.refresh,
        child: Scaffold(
          body: Center(child: Loader()),
        ),
      );
    }

    /// app error
    if (vm.showApError) {
      return RefreshIndicator(
        onRefresh: vm.refresh,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: errorWidget(),
          ),
        ),
      );
    }

    /// in case null

    if (vm.company == null) {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: vm.refresh,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(), child: SizedBox()),
        ),
      );
    }

    Text CompanyProfileForamtedText(String title, String description) {
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: ': ', style: descriptionFontStyleBold),
          TextSpan(
              text: description == null
                  ? StringResources.noneText
                  : description,
              style: descriptionFontStyle),
        ]),
        style: descriptionFontStyle,
      );
    }


    var header = ProfileSectionBase(
      sectionBody: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300])),
              margin: EdgeInsets.only(right: 10),
              child: CachedNetworkImage(
                placeholder: (context, _) => Image.asset(
                  kImagePlaceHolderAsset,
                  fit: BoxFit.cover,
                ),
                imageUrl: companyDetails.profilePicture ?? "",
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          companyDetails.name ??
                              StringResources.noneText,
                          style: headerTextStyle,
                        ),
                      ),
                      IconButton(
                        icon: Icon(FeatherIcons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      CompanyEditProfile(companyDetails)));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    var basicInfo = ProfileSectionBase(
      sectionIcon: FeatherIcons.userCheck,
      sectionLabel: StringResources.basicInfoText,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (companyDetails?.companyProfile != null)
            _htmlItem(context: context, label: StringResources.companyProfileText, value: companyDetails.companyProfile, valueKey: null),
//          Text.rich(TextSpan(children: [
//            TextSpan(
//                text: StringResources.companyProfileText + ': ',
//                style: descriptionFontStyleBold),
//            WidgetSpan(
//                child: Text(
//              companyDetails.companyProfile,
//              style: TextStyle(color: Colors.lightBlue),
//            ))
//          ])),
          SizedBox(height: 10),
          CompanyProfileForamtedText(
              StringResources.companyYearsOfEstablishmentText,
              companyDetails.yearOfEstablishment != null
                  ? DateFormatUtil.formatDate(
                      companyDetails.yearOfEstablishment)
                  : StringResources.noneText),
          companyDetails.basisMembershipNo!=null?SizedBox(
            height: 5,
          ):SizedBox(),
          companyDetails.basisMembershipNo!=null?CompanyProfileForamtedText(
              StringResources.companyBasisMembershipNoText,
              companyDetails.basisMembershipNo):SizedBox(),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var address = ProfileSectionBase(
      sectionLabel: StringResources.companyAddressSectionText,
      sectionIcon: FeatherIcons.map,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyDetails.address!=null?CompanyProfileForamtedText(
              StringResources.companyAddressText, companyDetails.address):SizedBox(),
          SizedBox(height: companyDetails.address!=null?5:0),

          companyDetails.area!=null?CompanyProfileForamtedText(
              StringResources.companyAreaText, companyDetails.area):SizedBox(),
          SizedBox(height: companyDetails.area!=null?5:0),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

          companyDetails.city!=null?CompanyProfileForamtedText(
              StringResources.companyCityText, companyDetails.city):SizedBox(),
          SizedBox(height: companyDetails.city!=null?5:0),
          if (companyDetails.country.isNotEmptyOrNotNull)
            CompanyProfileForamtedText(StringResources.companyCountryText,companyDetails.country),
          SizedBox(height: 5),
        ],
      ),
    );

    var contact = ProfileSectionBase(
        sectionLabel: StringResources.companyContactSectionText,
      sectionIcon: FeatherIcons.userCheck,
      sectionBody: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Company contact one
            companyDetails.companyContactNoOne == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: fontAwesomeIconSize,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(companyDetails.companyContactNoOne),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),

            //Company contact two
            companyDetails.companyContactNoTwo == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: fontAwesomeIconSize,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(companyDetails.companyContactNoTwo),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),

            //Company contact three
            companyDetails.companyContactNoThree == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: fontAwesomeIconSize,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(companyDetails.companyContactNoThree),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

            //Email
            if (companyDetails.email != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: StringResources.companyEmailText + ': ',
                        style: descriptionFontStyleBold),
                    WidgetSpan(
                      child: GestureDetector(
                          onTap: () {
                            UrlLauncherHelper.sendMail(
                                companyDetails.email.trim());
                          },
                          child: Text(
                            companyDetails.email ?? "",
                            softWrap: true,
                            style: TextStyle(color: Colors.lightBlue),
                          )),
                    )
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),

            //Web address
            companyDetails.webAddress == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text:
                                  StringResources.companyWebAddressText + ': ',
                              style: descriptionFontStyleBold),
                          WidgetSpan(
                            child: GestureDetector(
                                onTap: () {
                                  UrlLauncherHelper.launchUrl(
                                      companyDetails.webAddress.trim());
                                },
                                child: Text(
                                  companyDetails.webAddress,
                                  style: TextStyle(color: Colors.lightBlue),
                                )),
                          )
                        ]),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: companyDetails.webAddress == null?5:0,
                      ),
                    ],
                  ),
            SizedBox(
              height: companyDetails.webAddress == null?5:0,
            ),
          ],
        ),
      ),
    );

    var socialNetworks = ProfileSectionBase(
      sectionLabel: StringResources.companySocialNetworksSectionText,
      sectionIcon: FeatherIcons.cast,
      sectionBody: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Company facebook
            companyDetails.companyNameFacebook == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Facebook: ', style: descriptionFontStyleBold),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                UrlLauncherHelper.launchUrl(
                                    companyDetails.companyNameFacebook.trim());
                              },
                              child: Text(
                                companyDetails.companyNameFacebook,
                                style: TextStyle(color: Colors.lightBlue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

            //Company bdjobs
            companyDetails.companyNameBdjobs == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('BdJobs: ', style: descriptionFontStyleBold),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                UrlLauncherHelper.launchUrl(
                                    companyDetails.companyNameFacebook.trim());
                              },
                              child: Text(
                                companyDetails.companyNameBdjobs,
                                style: TextStyle(color: Colors.lightBlue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

            //Company google
            companyDetails.companyNameGoogle == null
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Google: ',
                            style: descriptionFontStyleBold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                UrlLauncherHelper.launchUrl(
                                    companyDetails.companyNameGoogle.trim());
                              },
                              child: Text(
                                companyDetails.companyNameGoogle,
                                style: TextStyle(color: Colors.lightBlue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );

    var organizationHead = ProfileSectionBase(
      sectionIcon: FeatherIcons.userCheck,
      sectionLabel: StringResources.companyOrganizationHeadSectionText,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyDetails.organizationHead!=null?CompanyProfileForamtedText(
              StringResources.companyOrganizationHeadNameText,
              companyDetails.organizationHead):SizedBox(),
          SizedBox(
            height: companyDetails.organizationHead!=null?5:0,
          ),
          companyDetails.organizationHeadDesignation!=null?CompanyProfileForamtedText(
              StringResources.companyOrganizationHeadDesignationText,
              companyDetails.organizationHeadDesignation):SizedBox(),
          SizedBox(
            height: companyDetails.organizationHeadDesignation!=null?5:0,
          ),
          companyDetails.organizationHeadNumber!=null?CompanyProfileForamtedText(
              StringResources.companyOrganizationHeadMobileNoText,
              companyDetails.organizationHeadNumber):SizedBox(),
          SizedBox(
            height: companyDetails.organizationHeadNumber!=null?5:0,
          ),
        ],
      ),
    );

    var contactPerson = ProfileSectionBase(
      sectionLabel: StringResources.companyContactPersonSectionText,
      sectionIcon: FeatherIcons.userCheck,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyDetails.contactPerson!=null?CompanyProfileForamtedText(
              StringResources.companyContactPersonNameText,
              companyDetails.contactPerson):SizedBox(),
          SizedBox(
            height: 5,
          ),

          companyDetails.contactPersonDesignation!=null?CompanyProfileForamtedText(
              StringResources.companyContactPersonDesignationText,
              companyDetails.contactPersonDesignation):SizedBox(),
          SizedBox(
            height: companyDetails.contactPersonDesignation!=null?5:0,
          ),

          companyDetails.contactPersonMobileNo!=null?CompanyProfileForamtedText(
              StringResources.companyContactPersonMobileNoText,
              companyDetails.contactPersonMobileNo):SizedBox(),
          SizedBox(
            height: companyDetails.contactPersonMobileNo!=null?5:0,
          ),

          companyDetails.contactPersonEmail!=null?CompanyProfileForamtedText(
              StringResources.companyContactPersonEmailText,
              companyDetails.contactPersonEmail):SizedBox(),
          SizedBox(
            height: companyDetails.contactPersonEmail!=null?5:0,
          ),
//
//          richText(StringUtils.companyPostCodeText, companyDetails.postCode),
//          SizedBox(height: 5,),
        ],
      ),
    );

    var otherInfo = ProfileSectionBase(
      sectionLabel: StringResources.companyOtherInformationText,
      sectionIcon: FontAwesomeIcons.exclamationCircle,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyDetails.legalStructure!=null?CompanyProfileForamtedText(StringResources.companyLegalStructureText,
              companyDetails.legalStructure):SizedBox(),
          SizedBox(
            height: companyDetails.legalStructure!=null?5:0,
          ),
          companyDetails.legalStructure!=null?CompanyProfileForamtedText(
              StringResources.companyNoOFHumanResourcesText,
              companyDetails.noOfHumanResources):SizedBox(),
          SizedBox(
            height: companyDetails.legalStructure!=null?5:0,
          ),
          companyDetails.legalStructure!=null?CompanyProfileForamtedText(StringResources.companyNoOFItResourcesText,
              companyDetails.noOfResources):SizedBox(),
          SizedBox(
            height: companyDetails.legalStructure!=null?5:0,
          ),
        ],
      ),
    );

    var googleMap = ProfileSectionBase(
      sectionLabel: StringResources.companyLocationOnMapText,
      sectionIcon: FeatherIcons.mapPin,
      sectionBody: (companyDetails?.latitude != null &&
              companyDetails?.longitude != null)
          ? ShowLocationOnMapWidget(
              latLng: LatLng(companyDetails.latitude, companyDetails.longitude),
              markerLabel: companyDetails.name,
            )
          : SizedBox(),
    );

    return Scaffold(
//      appBar: AppBar(
//        title: Text(StringResources.companyDetailsText),
//      ),
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: backgroundColor,
              child: Column(
                children: [
                  header,
                  sectionDivider,
                  basicInfo,
                  sectionDivider,
                  address,
                  sectionDivider,
                  contact,
                  sectionDivider,
                  socialNetworks,
                  sectionDivider,
                  organizationHead,
                  sectionDivider,
                  contactPerson,
                  sectionDivider,
                  otherInfo,
                  sectionDivider,
                  googleMap,
                  sectionDivider,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _htmlItem(
      {@required BuildContext context,
        @required String label,
        @required String value,
        @required Key valueKey}) {
//    double width = MediaQuery.of(context).size.width > 720 ? 160 : 130;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("$label: ",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Expanded(child: HtmlWidget("${value ?? ""}", key: valueKey,)),
        ],),
    );}
}
