import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/company_edit_profile.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile();

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> with AfterLayoutMixin {
  static double _cameraZoom = 10.4746;
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(23.7104, 90.40744),
    zoom: _cameraZoom,
  );
  final Widget sectionDivider = SizedBox(
    height: 1.5,
  );

  List<Marker> markers = [];

  Future<void> _goToPosition(Company company) async {
    var markId = MarkerId(company.name);
    Marker _marker = Marker(
      onTap: () {
        print("tapped");
      },
      position: LatLng(company.latitude, company.longitude),
      infoWindow: InfoWindow(title: company.name ?? ""),
      markerId: markId,
    );
    markers.add(_marker);
    final GoogleMapController _googleMapController = await _controller.future;
    var position = CameraPosition(
      target: LatLng(company.latitude, company.longitude),
      zoom: _cameraZoom,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var vm = Provider.of<CompanyProfileViewModel>(context, listen: false);
    vm.getCompanyDetails().then((c) {
      if (c?.latitude != null && c?.longitude != null) _goToPosition(c);
    });
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
    double iconSize = 14;
    double sectionIconSize = 20;
    Color clockIconColor = Colors.orange;

    Color sectionColor = Theme.of(context).backgroundColor;
    Color summerySectionBorderColor = Colors.grey[300];
    Color summerySectionColor =
        !isDarkMode ? Colors.grey[200] : Colors.grey[600];
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];

// widgets

    var vm = Provider.of<CompanyProfileViewModel>(context);
    Company companyDetails = vm.company;

    if (companyDetails == null) {
      return Scaffold(
        body: Center(child: Loader()),
      );
    }
    Text richText(String title, String description) {
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: ': ', style: descriptionFontStyleBold),
          TextSpan(
              text: description == null
                  ? StringResources.unspecifiedText
                  : description,
              style: descriptionFontStyle),
        ]),
        style: descriptionFontStyle,
      );
    }

    var header = SectionBase(
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
                              StringResources.unspecifiedText,
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

    var basicIfno2 = SectionBase(
      sectionIcon: FeatherIcons.userCheck,
      sectionLabel: StringResources.basicInfoText,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if( companyDetails?.companyProfile != null)
        Text.rich(TextSpan(children: [
          TextSpan(
              text: StringResources.companyProfileText + ': ',
              style: descriptionFontStyleBold),
          WidgetSpan(
              child: GestureDetector(
                  onTap: () {
                    UrlLauncherHelper.launchUrl(
                        companyDetails.companyProfile.trim());
                  },
                  child: Text(
                    companyDetails.companyProfile,
                    style: TextStyle(color: Colors.lightBlue),
                  )))
        ])),
          SizedBox(
            height: 5
          ),

          richText(
              StringResources.companyYearsOfEstablishmentText,
              companyDetails.yearOfEstablishment != null
                  ? DateFormatUtil.formatDate(companyDetails.yearOfEstablishment)
                  : StringResources.unspecifiedText),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyBasisMembershipNoText,
              companyDetails.basisMemberShipNo),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    var basicInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FeatherIcons.userCheck,
              size: fontAwesomeIconSize,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              StringResources.basicInfoText,
              style: sectionTitleFont,
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),

        //Company Profile
        companyDetails.companyProfile == null
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: StringResources.companyProfileText + ': ',
                        style: descriptionFontStyleBold),
                    WidgetSpan(
                        child: GestureDetector(
                            onTap: () {
                              UrlLauncherHelper.launchUrl(
                                  companyDetails.companyProfile.trim());
                            },
                            child: Text(
                              companyDetails.companyProfile,
                              style: TextStyle(color: Colors.lightBlue),
                            )))
                  ])),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

        richText(
            StringResources.companyYearsOfEstablishmentText,
            companyDetails.yearOfEstablishment != null
                ? DateFormatUtil.formatDate(companyDetails.yearOfEstablishment)
                : StringResources.unspecifiedText),
        SizedBox(
          height: 5,
        ),

        richText(StringResources.companyBasisMembershipNoText,
            companyDetails.basisMemberShipNo),
        SizedBox(
          height: 5,
        ),
      ],
    );

    var address = SectionBase(
      sectionLabel: StringResources.companyAddressSectionText,
      sectionIcon: FeatherIcons.map,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          richText(StringResources.companyAddressText, companyDetails.address),
          SizedBox(
            height: 5,
          ),
//
//          richText(StringUtils.companyIndustryText, companyDetails.companyProfile),
//          SizedBox(height: 5,),

          richText(
              StringResources.companyDistrictText, companyDetails.district),
          SizedBox(
            height: 5,
          ),

          richText(
              StringResources.companyPostCodeText, companyDetails.postCode),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var contact = SectionBase(
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
                        height: 5,
                      ),
                    ],
                  ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );

    var socialNetworks = SectionBase(
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

    var organizationHead = SectionBase(
      sectionIcon: FeatherIcons.userCheck,
      sectionLabel: StringResources.companyOrganizationHeadSectionText,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          richText(StringResources.companyOrganizationHeadNameText,
              companyDetails.organizationHead),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyOrganizationHeadDesignationText,
              companyDetails.organizationHeadDesignation),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyOrganizationHeadMobileNoText,
              companyDetails.organizationHeadNumber),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var contactPerson = SectionBase(
      sectionLabel: StringResources.companyContactPersonSectionText,
      sectionIcon: FeatherIcons.userCheck,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          richText(StringResources.companyContactPersonNameText,
              companyDetails.contactPerson),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonDesignationText,
              companyDetails.contactPersonDesignation),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonMobileNoText,
              companyDetails.contactPersonMobileNo),
          SizedBox(
            height: 5,
          ),

          richText(StringResources.companyContactPersonEmailText,
              companyDetails.contactPersonEmail),
          SizedBox(
            height: 5,
          ),
//
//          richText(StringUtils.companyPostCodeText, companyDetails.postCode),
//          SizedBox(height: 5,),
        ],
      ),
    );

    var otherInfo = SectionBase(
      sectionLabel: StringResources.companyOtherInformationText,
      sectionIcon: FontAwesomeIcons.exclamationCircle,
      sectionBody: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          richText(StringResources.companyLegalStructureText,
              companyDetails.legalStructure),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyNoOFHumanResourcesText,
              companyDetails.noOfHumanResources),
          SizedBox(
            height: 5,
          ),
          richText(StringResources.companyNoOFItResourcesText,
              companyDetails.noOfResources),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    var googleMap = SectionBase(
      sectionLabel:      StringResources.companyLocationOnMapText,
      sectionIcon:       FeatherIcons.mapPin,
      sectionBody: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            markers: markers.toSet(),
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(
                      () => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ),
      ],
    ),);

    return Scaffold(
//      appBar: AppBar(
//        title: Text(StringResources.companyDetailsText),
//      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: [
                header,
                sectionDivider,
                basicIfno2,
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
    );
  }
}

class SectionBase extends StatelessWidget {
  final Widget sectionBody;
  final IconData sectionIcon;
  final String sectionLabel;

  SectionBase({
    @required this.sectionBody,
    this.sectionIcon,
    this.sectionLabel,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle sectionTitleFont =
        TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    Color sectionColor = Theme.of(context).backgroundColor;
    double fontAwesomeIconSize = 15;
    double iconSize = 14;
    double sectionIconSize = 20;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionIcon != null || sectionLabel != null)
            Row(
              children: <Widget>[
                Icon(
                  sectionIcon,
                  size: fontAwesomeIconSize,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  sectionLabel,
                  style: sectionTitleFont,
                )
              ],
            ),
          SizedBox(
            height: 5,
          ),
          if (sectionBody != null) sectionBody
        ],
      ),
    );
  }
}
