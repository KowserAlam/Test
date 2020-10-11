import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/company_edit_profile.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/profile_section_base.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';
import 'package:jobxprss_company/main_app/views/widgets/show_location_on_map_widget.dart';
import 'package:jobxprss_company/method_extension.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile();

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  //Styles
  static bool isDarkMode = Theme.of(Get.context).brightness == Brightness.dark;
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

  final Widget sectionDivider = SizedBox(
    height: 1.5,
  );
  CompanyProfileViewModel vm;

  @override
  void initState() {
    Get.put(CompanyProfileViewModel());
    vm = Get.find<CompanyProfileViewModel>();
    vm.getCompanyDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CompanyProfileViewModel(),
        builder: (CompanyProfileViewModel vm) {
          Company companyDetails = vm.company;
          return Scaffold(
//      appBar: AppBar(
//        title: Text(StringResources.companyDetailsText),
//      ),
            body: PageStateBuilder(
              onRefresh: vm.refresh,
              showLoader: vm.showLoading,
              showError: vm.showApError,
              appError: vm.appError,
              child: SingleChildScrollView(
                key: Key('companyViewProfileListViewKey'),
                child: companyDetails == null
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(10),
                        color: backgroundColor,
                        child: Column(
                          children: [
                            header(companyDetails),
                            sectionDivider,
                            basicInfo(companyDetails),
                            sectionDivider,
                            address(companyDetails),
                            sectionDivider,
                            contact(companyDetails),
                            sectionDivider,
                            socialNetworks(companyDetails),
                            sectionDivider,
                            organizationHead(companyDetails),
                            sectionDivider,
                            contactPerson(companyDetails),
                            sectionDivider,
                            otherInfo(companyDetails),
                            sectionDivider,
                            googleMap(companyDetails),
                            sectionDivider,
                          ],
                        ),
                      ),
              ),
            ),
          );
        });
  }

  Widget _htmlItem(
      {@required BuildContext context,
      @required String label,
      @required String value,
      @required Key valueKey}) {
//    double width = MediaQuery.of(context).size.width > 720 ? 160 : 130;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Expanded(
              child: HtmlWidget(
            "${value ?? ""}",
            key: valueKey,
          )),
        ],
      ),
    );
  }

  Text companyProfileFormattedText(String title, String description) {
    return Text.rich(
      TextSpan(children: <TextSpan>[
        TextSpan(text: title, style: descriptionFontStyleBold),
        TextSpan(text: ': ', style: descriptionFontStyleBold),
        TextSpan(
            text: description == null ? "" : description,
            style: descriptionFontStyle),
      ]),
      style: descriptionFontStyle,
    );
  }

  Widget header(Company companyDetails) => ProfileSectionBase(
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
                  imageUrl: companyDetails?.profilePicture ?? "",
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
                            companyDetails?.name ?? "",
                            style: headerTextStyle,
                          ),
                        ),
                        IconButton(
                          key: Key('companyEditProfileIconKey'),
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

  Widget basicInfo(Company companyDetails) => ProfileSectionBase(
        sectionIcon: FeatherIcons.userCheck,
        sectionLabel: StringResources.basicInfoText,
        sectionBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            companyDetails.companyProfile.htmlToNotusDocument
                        .toPlainText().trim()
                        .length != 0?
           _htmlItem(
               context: context,
               label: StringResources.companyProfileText,
               value: companyDetails.companyProfile,
               valueKey: null):SizedBox(),
            SizedBox(
                height: companyDetails.companyProfile.htmlToNotusDocument
                            .toPlainText().trim()
                    .length != 0
                    ? 5
                    : 0),
            companyDetails.yearOfEstablishment != null
                ?companyProfileFormattedText(
                StringResources.companyYearsOfEstablishmentText,
                 DateFormatUtil.formatDate(
                        companyDetails.yearOfEstablishment)):SizedBox(),
            companyDetails.basisMembershipNo.isNotEmptyOrNotNull
                ? SizedBox(
                    height: 5,
                  )
                : SizedBox(),
            companyDetails.basisMembershipNo.isNotEmptyOrNotNull
                ? companyProfileFormattedText(
                    StringResources.companyBasisMembershipNoText,
                    companyDetails.basisMembershipNo)
                : SizedBox(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );

  Widget address(Company companyDetails) => ProfileSectionBase(
        sectionLabel: StringResources.companyAddressSectionText,
        sectionIcon: FeatherIcons.map,
        sectionBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            companyDetails.address != null
                ? companyProfileFormattedText(
                    StringResources.companyAddressText, companyDetails.address)
                : SizedBox(),
            SizedBox(height: companyDetails.address != null ? 5 : 0),

            companyDetails.area != null
                ? companyProfileFormattedText(
                    StringResources.companyAreaText, companyDetails.area)
                : SizedBox(),
            SizedBox(height: companyDetails.area != null ? 5 : 0),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

            companyDetails.city != null
                ? companyProfileFormattedText(
                    StringResources.companyCityText, companyDetails.city)
                : SizedBox(),
            SizedBox(height: companyDetails.city != null ? 5 : 0),
            if (companyDetails.country.isNotEmptyOrNotNull)
              companyProfileFormattedText(
                  StringResources.companyCountryText, companyDetails.country),
            SizedBox(height: 5),
          ],
        ),
      );

  Widget contact(Company companyDetails) => ProfileSectionBase(
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
                                text: StringResources.companyWebAddressText +
                                    ': ',
                                style: descriptionFontStyleBold),
                            WidgetSpan(
                              child: GestureDetector(
                                  onTap: () {
                                    UrlLauncherHelper.launchUrl(
                                        companyDetails.webAddress.trim());
                                  },
                                  child: Text(
                                    companyDetails.webAddress,
                                    key: Key('companyViewProfileWebAddress'),
                                    style: TextStyle(color: Colors.lightBlue),
                                  )),
                            )
                          ]),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: companyDetails.webAddress == null ? 5 : 0,
                        ),
                      ],
                    ),
              SizedBox(
                height: companyDetails.webAddress == null ? 5 : 0,
              ),
            ],
          ),
        ),
      );

  Widget socialNetworks(Company companyDetails) => ProfileSectionBase(
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
                            GestureDetector(
                                onTap: () {
                                  UrlLauncherHelper.launchUrl(companyDetails
                                      .companyNameFacebook
                                      .trim());
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
                            GestureDetector(
                                onTap: () {
                                  UrlLauncherHelper.launchUrl(companyDetails
                                      .companyNameFacebook
                                      .trim());
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

  Widget organizationHead(Company companyDetails) => ProfileSectionBase(
        sectionIcon: FeatherIcons.userCheck,
        sectionLabel: StringResources.companyOrganizationHeadSectionText,
        sectionBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            companyDetails.organizationHead != null
                ? companyProfileFormattedText(
                    StringResources.companyOrganizationHeadNameText,
                    companyDetails.organizationHead)
                : SizedBox(),
            SizedBox(
              height: companyDetails.organizationHead != null ? 5 : 0,
            ),
            companyDetails.organizationHeadDesignation != null
                ? companyProfileFormattedText(
                    StringResources.companyOrganizationHeadDesignationText,
                    companyDetails.organizationHeadDesignation)
                : SizedBox(),
            SizedBox(
              height:
                  companyDetails.organizationHeadDesignation != null ? 5 : 0,
            ),
            companyDetails.organizationHeadNumber != null
                ? companyProfileFormattedText(
                    StringResources.companyOrganizationHeadMobileNoText,
                    companyDetails.organizationHeadNumber)
                : SizedBox(),
            SizedBox(
              height: companyDetails.organizationHeadNumber != null ? 5 : 0,
            ),
          ],
        ),
      );

  Widget contactPerson(Company companyDetails) => ProfileSectionBase(
        sectionLabel: StringResources.companyContactPersonSectionText,
        sectionIcon: FeatherIcons.userCheck,
        sectionBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            companyDetails.contactPerson != null
                ? companyProfileFormattedText(
                    StringResources.companyContactPersonNameText,
                    companyDetails.contactPerson)
                : SizedBox(),
            SizedBox(
              height: 5,
            ),

            companyDetails.contactPersonDesignation != null
                ? companyProfileFormattedText(
                    StringResources.companyContactPersonDesignationText,
                    companyDetails.contactPersonDesignation)
                : SizedBox(),
            SizedBox(
              height: companyDetails.contactPersonDesignation != null ? 5 : 0,
            ),

            companyDetails.contactPersonMobileNo != null
                ? companyProfileFormattedText(
                    StringResources.companyContactPersonMobileNoText,
                    companyDetails.contactPersonMobileNo)
                : SizedBox(),
            SizedBox(
              height: companyDetails.contactPersonMobileNo != null ? 5 : 0,
            ),

            companyDetails.contactPersonEmail != null
                ? companyProfileFormattedText(
                    StringResources.companyContactPersonEmailText,
                    companyDetails.contactPersonEmail)
                : SizedBox(),
            SizedBox(
              height: companyDetails.contactPersonEmail != null ? 5 : 0,
            ),
//
//          richText(StringUtils.companyPostCodeText, companyDetails.postCode),
//          SizedBox(height: 5,),
          ],
        ),
      );

  Widget otherInfo(Company companyDetails) => ProfileSectionBase(
        sectionLabel: StringResources.companyOtherInformationText,
        sectionIcon: FontAwesomeIcons.exclamationCircle,
        sectionBody: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            companyDetails.legalStructure != null
                ? companyProfileFormattedText(
                    StringResources.companyLegalStructureText,
                    companyDetails.legalStructure)
                : SizedBox(),
            SizedBox(
              height: companyDetails.legalStructure != null ? 5 : 0,
            ),
            companyDetails.legalStructure != null
                ? companyProfileFormattedText(
                    StringResources.companyNoOFHumanResourcesText,
                    companyDetails.noOfHumanResources)
                : SizedBox(),
            SizedBox(
              height: companyDetails.legalStructure != null ? 5 : 0,
            ),
            companyDetails.legalStructure != null
                ? companyProfileFormattedText(
                    StringResources.companyNoOFItResourcesText,
                    companyDetails.noOfResources)
                : SizedBox(),
            SizedBox(
              height: companyDetails.legalStructure != null ? 5 : 0,
            ),
          ],
        ),
      );

  Widget googleMap(Company companyDetails) => ProfileSectionBase(
        sectionLabel: StringResources.companyLocationOnMapText,
        sectionIcon: FeatherIcons.mapPin,
        sectionBody: (companyDetails?.latitude != null &&
                companyDetails?.longitude != null)
            ? ShowLocationOnMapWidget(
                latLng:
                    LatLng(companyDetails.latitude, companyDetails.longitude),
                markerLabel: companyDetails.name,
              )
            : SizedBox(),
      );
}
