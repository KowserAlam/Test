import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/models/contact_us_model.dart';
import 'package:jobxprss_company/main_app/models/settings_model.dart';
import 'package:jobxprss_company/main_app/repositories/contact_us_submit_repository.dart';
import 'package:jobxprss_company/main_app/repositories/setting_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/pge_view_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dartz/dartz.dart' as dartZ;


class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode subjectFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  SettingsModel _settingsModel;
  getSettingsDetails() async {
    dartZ.Either<AppError, SettingsModel> result =
    await SettingsRepository().getSettingInfo();
    return result.fold((l) {
      print(l);
    }, (SettingsModel settingsModel) {
      print(settingsModel.id);
      _settingsModel = settingsModel;
      double lat = double.parse(settingsModel.latitude);
      double long = double.parse(settingsModel.longitude);

      if (lat != null && long != null) {
        _goToPosition(lat: lat, long: long);
      }
//      getCompany(jobDetails);
      setState(() {});
    });
  }

  Future<bool> addContactUsData(ContactUsModel contactUsModel){
    return ContactUsSubmitRepository().addContactUsData(contactUsModel).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        BotToast.showText(text: StringResources.contactUsSubmittedText);
        _submitted = true;
        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();
        phoneController.clear();
        setState(() {

        });
        return true;
      });
    });
  }

  static double _cameraZoom = 10.4746;
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(23.7104, 90.40744),
    zoom: _cameraZoom,
  );

  List<Marker> markers = [];

  Future<void> _goToPosition({double lat, double long}) async {
    var markId = MarkerId("Ishraak Solutions");
    Marker _marker = Marker(
      onTap: () {
        print("tapped");
      },
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Ishraak Solutions"),
      markerId: markId,
    );
    markers.add(_marker);
    final GoogleMapController _googleMapController = await _controller.future;
    var position = CameraPosition(
      target: LatLng(lat, long),
      zoom: _cameraZoom,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  void initState() {
    getSettingsDetails();
    super.initState();
  }

  void _handleSave(){
    var contactUsModel = ContactUsModel(
        name: nameController.text??"",
        email: emailController.text??"",
        subject: subjectController.text??"",
        message: messageController.text??"",
        phone: phoneController.text??""
    );

    bool isValid = _formKey.currentState.validate();
    if(isValid){
      addContactUsData(contactUsModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle sectionTitleFont = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle descriptionFontStyleBold = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;

    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 18);
    Widget contactInfoItems(IconData iconData, String data){
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData, size: 15,),
          SizedBox(width: 5,),
          Text(data, style: TextStyle(fontSize: 13),)
        ],
      );
    };

    var spaceBetweenLines = SizedBox(height: 10,);
    var googleMap = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FeatherIcons.mapPin,
              size: fontAwesomeIconSize,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              StringResources.contactUsLocationText,
              style: sectionTitleFont,
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300])
          ),
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
    );

    if(_settingsModel == null)
      return Scaffold(
        appBar: AppBar(
          title: Text(StringResources.contactUsText),
        ),
        body: Center(
          child: Loader(),
        ),
      );
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.contactUsText),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: AppTheme.lightLinearGradient,
                      border: Border.all(width: 1, color: Colors.grey[300]),
                      //color: Colors.grey[200]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringResources.contactUsContactInfoText,style: titleStyle,),
                        Divider(height: 25,),
                        contactInfoItems(Icons.pin_drop, _settingsModel.address),
                        spaceBetweenLines,
                        contactInfoItems(Icons.mail_outline, _settingsModel.supportEmail),
                        spaceBetweenLines,
                        contactInfoItems(Icons.phone_in_talk, _settingsModel.phone),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text(StringResources.contactUsKeepInTouchText, style: titleStyle,),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        hintText: StringResources.contactUsNameText,
                        controller: nameController,
                        validator: Validator().nullFieldValidate,
                        onFieldSubmitted: (v){
                          nameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(emailFocusNode);
                        },
                      ),
                      spaceBetweenLines,
                      CustomTextFormField(
                        hintText: StringResources.contactUsEmailText,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validator().validateEmail,
                        focusNode: emailFocusNode,
                        onFieldSubmitted: (v){
                          nameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        },
                      ),
                      spaceBetweenLines,
                      CustomTextFormField(
                        hintText: StringResources.contactUsPhoneText,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: Validator().validatePhoneNumber,
                        focusNode: phoneFocusNode,
                        onFieldSubmitted: (v){
                          nameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(subjectFocusNode);
                        },
                      ),
                      spaceBetweenLines,
                      CustomTextFormField(
                        hintText: StringResources.contactUsSubjectText,
                        controller: subjectController,
                        validator: Validator().nullFieldValidate,
                        focusNode: subjectFocusNode,
                        onFieldSubmitted: (v){
                          nameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(messageFocusNode);
                        },
                      ),
                      spaceBetweenLines,
                      CustomTextFormField(
                        hintText: StringResources.contactUsMessageText,
                        controller: messageController,
                        validator: Validator().nullFieldValidate,
                        maxLines: 5,
                        focusNode: messageFocusNode,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: CommonButton(
              label: 'Submit',
              onTap: (){
                _handleSave();
              },
            ),
          ),
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.all(15),
            child: googleMap,
          )
        ],
      ),
    );
  }
}
