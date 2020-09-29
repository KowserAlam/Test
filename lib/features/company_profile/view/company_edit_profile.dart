import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/change_image_profile_widget.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/location_picker.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_edit_profile_view_model.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/image_util.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:jobxprss_company/method_extension.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CompanyEditProfile extends StatefulWidget {
  final Company company;

  CompanyEditProfile(this.company);

  @override
  _CompanyEditProfileState createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  TextStyle labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold
  );

  Company company;
  var _formKey = GlobalKey<FormState>();
  File profileImage;
  String selectedCountry;
  double latitude;
  double longitude;
  var _companyNameTextController = TextEditingController();
  ZefyrController _companyProfileTextController = ZefyrController(NotusDocument());
  var _legalStructureTextController = TextEditingController();
  var _noOfHumanResourceTextController = TextEditingController();
  var _noOfITResourceTextController = TextEditingController();
  var _basisMembershipNoTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _areaTextController = TextEditingController();

  // var _cityTextController = TextEditingController();
  var _contactNo1TextController = TextEditingController();
  var _contactNo2TextController = TextEditingController();
  var _contactNo3TextController = TextEditingController();
  var _emailTextController = TextEditingController();
  var _webAddressTextController = TextEditingController();
  var _companyFacebookTextController = TextEditingController();
  var _companyBdJobsTextController = TextEditingController();
  var _companyGoogleTextController = TextEditingController();
  var _orgHeadNameTextController = TextEditingController();
  var _orgHeadDesignationTextController = TextEditingController();
  var _orgHeadPhoneTextController = TextEditingController();
  var _contactPersonNameTextController = TextEditingController();
  var _contactPersonEmailTextController = TextEditingController();
  var _contactPersonPhoneTextController = TextEditingController();
  var _contactPersonDesignationTextController = TextEditingController();
  DateTime yearOfEstablishment;
  FocusNode _companyProfileFocusNode = FocusNode();

  var spaceBetween = SizedBox(
    height: 10,
  );

  CompanyEditProfileViewModel editProfileVm ;
  @override
  void initState() {
    Get.put(CompanyEditProfileViewModel());
    editProfileVm =Get.find<CompanyEditProfileViewModel>();
    editProfileVm.getCountryList();
    company = widget.company;
    _companyNameTextController.text = company.name;
    if(company.companyProfile != null){
      _companyProfileTextController = ZefyrController(company.companyProfile.htmlToNotusDocument);
    }
    yearOfEstablishment = company.yearOfEstablishment;
    _legalStructureTextController.text = company.legalStructure;
    _noOfHumanResourceTextController.text = company.noOfHumanResources;
    _noOfITResourceTextController.text = company.noOfItResources;
    _basisMembershipNoTextController.text = company.basisMembershipNo;
    _addressTextController.text = company.address;
    _areaTextController.text = company.area;
    // _cityTextController.text = company.district;
    _contactNo1TextController.text = company.companyContactNoOne;
    _contactNo2TextController.text = company.companyContactNoTwo;
    _contactNo3TextController.text = company.companyContactNoThree;
    _emailTextController.text = company.email;
    _webAddressTextController.text = company.webAddress;
    _companyFacebookTextController.text = company.companyNameFacebook;
    _companyBdJobsTextController.text = company.companyNameBdjobs;
    _companyGoogleTextController.text = company.companyNameGoogle;
    _orgHeadNameTextController.text = company.organizationHead;
    _orgHeadDesignationTextController.text =
        company.organizationHeadDesignation;
    _orgHeadPhoneTextController.text = company.organizationHeadNumber;
    _contactPersonNameTextController.text = company.contactPerson;
    _contactPersonDesignationTextController.text =
        company.contactPersonDesignation;
    _contactPersonEmailTextController.text = company.contactPersonEmail;
    _contactPersonPhoneTextController.text = company.contactPersonMobileNo;
    latitude = company.latitude;
    longitude = company.longitude;
    selectedCountry = company.city;
    super.initState();
  }

  _handleSave() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      var companyVm =
          Provider.of<CompanyProfileViewModel>(context, listen: false);
      Map<String, dynamic> data = {
        "year_of_eastablishment": yearOfEstablishment?.toYYYMMDDString,
        "legal_structure_of_this_company": _legalStructureTextController.text.getStringInNotNull,
        "company_profile": _companyProfileTextController.document.toHTML.getStringInNotNull,
        "basis_membership_no": _basisMembershipNoTextController.text,
        "address": _addressTextController.text.getStringInNotNull,
        "area": _areaTextController.text.getStringInNotNull,
        // "city": _cityTextController.text,
        "city": selectedCountry.swapValueByComa.getStringInNotNull,
        "company_contact_no_one": _contactNo1TextController.text.getStringInNotNull,
        "company_contact_no_two": _contactNo2TextController.text.getStringInNotNull,
        "company_contact_no_three": _contactNo3TextController.text.getStringInNotNull,
        "email": _emailTextController.text.getStringInNotNull,
        "web_address": _webAddressTextController.text.getStringInNotNull,
        "company_name_bdjobs": _companyBdJobsTextController.text.getStringInNotNull,
        "company_name_facebook": _companyFacebookTextController.text.getStringInNotNull,
        "company_name_google": _companyGoogleTextController.text.getStringInNotNull,
        "organization_head": _orgHeadNameTextController.text.getStringInNotNull,
        "organization_head_designation": _orgHeadDesignationTextController.text.getStringInNotNull,
        "organization_head_number": _orgHeadPhoneTextController.text.getStringInNotNull,
        "total_number_of_human_resources":
            _noOfHumanResourceTextController.text.getStringInNotNull,
        "no_of_it_resources": _noOfITResourceTextController.text.getStringInNotNull,
        "contact_person": _contactPersonNameTextController.text.getStringInNotNull,
        "image": profileImage != null?ImageUtil.getBase64Image(profileImage):null,
        "contact_person_designation":
            _contactPersonDesignationTextController.text.getStringInNotNull,
        "contact_person_mobile_no": _contactPersonPhoneTextController.text.getStringInNotNull,
        "contact_person_email": _contactPersonEmailTextController.text.getStringInNotNull,
        "latitude": latitude.toStringAsFixed(8) ?? null,
        "longitude": longitude.toStringAsFixed(8) ?? null,
      };
      Logger().i(data);
//
//      if (profileImage != null) {
//        data.addAll({"profile_picture": profileImage.readAsBytesSync()});
//      }
      var res = await companyVm.updateCompany(data, imageFile: profileImage);
      if (res) {
        Navigator.pop(context);
      }
    } else {
      Get.snackbar(
          StringResources.errorText, StringResources.checkRequiredField,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
// var editProfileVm = Provider.of<CompanyEditProfileViewModel>(context);

    return ZefyrScaffold(
      child: Scaffold(
        
        appBar: AppBar(
          title: Text(
            StringResources.updateInfoText,
            key: Key('companyEditProfileAppBarKey'),
          ),
          actions: [
            EditScreenSaveButton(
              text: StringResources.saveText,
              key: Key('editProfileSaveButton'),
              onPressed: _handleSave,
            )
          ],
        ),
        body: ListView(
          key: Key('companyEditProfileListViewKey'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    header(),
                    basicInfo(),
                    address(context),
                    contact(),
                    orgHead(),
                    contactPerson(),
                    otherInfo(),
                    setLocation(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget header ()=> Column(
    children: [
      spaceBetween,
      ChangeProfileImage(
        onImageSelect: (v) {
          profileImage = v;
        },
      ),
      spaceBetween,
      //name
      CustomTextFormField(
        enabled: false,
        readOnly: true,
        keyboardType: TextInputType.text,
        //focusNode: _fatherNameFocusNode,
//                    textInputAction: TextInputAction.next,
        onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_motherNameFocusNode);
        },
        controller: _companyNameTextController,
        labelText: StringResources.companyNameText,
        hintText: StringResources.companyNameHint,
        textFieldKey: Key('companyNameTextfieldKey'),
      ),
      spaceBetween,
    ],
  );

  Widget basicInfo ()=> Column(
    children: [
      spaceBetween,
      Text(
        StringResources.basicInfoText,
        style: labelStyle,
      ),
      spaceBetween,
      //company_profile
      CustomZefyrRichTextFormField(
        labelText: StringResources.companyProfileText,
        textFieldKey: Key('companyProfileTextfieldKey'),
        focusNode: _companyProfileFocusNode,
        controller: _companyProfileTextController,
        height: 80,
      ),
      spaceBetween,
      //Year of Establishment
      CommonDatePickerFormField(
        date: yearOfEstablishment,
        onDateTimeChanged: (DateTime t) {
          yearOfEstablishment = t;
          setState(() {});
        },
        label: StringResources.companyYearsOfEstablishmentText,
        dateFieldKey: Key('companyYearsOfEstablishmentDateFieldKey'),
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('legalStructureTextKey'),
        keyboardType: TextInputType.text,
        controller: _legalStructureTextController,
        labelText: StringResources.legalStructureText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyNoOFHumanResourcesTextKey'),
        validator: Validator().integerNumberNullableValidator,
        keyboardType: TextInputType.number,
        controller: _noOfHumanResourceTextController,
        labelText: StringResources.companyNoOFHumanResourcesText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyNoOFItResourcesTextKey'),
        validator: Validator().integerNumberNullableValidator,
        keyboardType: TextInputType.number,
        controller: _noOfITResourceTextController,
        labelText: StringResources.companyNoOFItResourcesText,
      ),
      //Legal Structure
      spaceBetween,
    ],
  );
  Widget address (context){

    return Column(
    children: [
      spaceBetween,
      Text(
        StringResources.companyAddressSectionText,
        style: labelStyle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyAddressTextfieldKey'),
        isRequired: true,
        keyboardType: TextInputType.multiline,
        minLines: 3,
        maxLines: 8,
        controller: _addressTextController,
        labelText: StringResources.addressText,
        hintText: StringResources.addressHintText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyAreaTextfieldKey'),
        controller: _areaTextController,
        labelText: StringResources.areaText,
        hintText: StringResources.areaHintText,
      ),
      spaceBetween,
      // CustomTextFormField(
      //   keyboardType: TextInputType.text,
      //   controller: _cityTextController,
      //   labelText: StringResources.companyCityText,
      //   hintText: StringResources.companyCityEg,
      // ),
      // spaceBetween,
      CustomDropdownSearchFormField<String>(
        dropdownKey: Key('CompanyCityDropdownListKey'),
        labelText: StringResources.companyCityText,
        hintText: StringResources.tapToSelectText,
        items: editProfileVm.countryList,
        mode: Mode.BOTTOM_SHEET,
        showSearchBox: true,
        autoFocusSearchBox: true,
        showSelectedItem: true,
        selectedItem: selectedCountry,
        onChanged: (v) {
          selectedCountry = v;
        },
      )


    ],
  );
  }
  Widget contact ()=> Column(
    children: [
      spaceBetween,
      Text(
        StringResources.contactText,
        style: labelStyle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('contactNoTextfieldNo1Key'),
        keyboardType: TextInputType.phone,
        isRequired: true,
        validator: Validator().validatePhoneNumber,
        hintText: StringResources.phoneHintText,
        controller: _contactNo1TextController,
        labelText: StringResources.contactNoOneText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('contactNoTextfieldNo2Key'),
        keyboardType: TextInputType.phone,
        validator: Validator().validateNullablePhoneNumber,
        hintText: StringResources.phoneHintText,
        controller: _contactNo2TextController,
        labelText: StringResources.contactNoTwoText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('contactNoTextfieldNo3Key'),
        keyboardType: TextInputType.phone,
        validator: Validator().validateNullablePhoneNumber,
        hintText: StringResources.phoneHintText,
        controller: _contactNo3TextController,
        labelText: StringResources.contactNoThreeText,
      ),
//            spaceBetween,
//            CustomTextFormField(
//              validator: Validator().validateEmail,
//              hintText: StringResources.emailHintText,
//              controller: _emailTextController,
//              labelText: StringResources.emailText,
//            ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyWebAddressTextfieldKey'),
        hintText: StringResources.webAddressHintText,
        controller: _webAddressTextController,
        labelText: StringResources.companyWebAddressText,
      ),
      spaceBetween,
    ],
  );
  Widget orgHead ()=> Column(
    children: [
      spaceBetween,
      Text(
        StringResources.companyOrganizationHeadSectionText,
        style: labelStyle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyOrganizationHeadNameTextKey'),
        keyboardType: TextInputType.text,
        isRequired: true,
        controller: _orgHeadNameTextController,
        labelText: StringResources.companyOrganizationHeadNameText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyOrganizationHeadDesignationTextKey'),
        keyboardType: TextInputType.text,
        controller: _orgHeadDesignationTextController,
        labelText: StringResources.companyOrganizationHeadDesignationText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyOrganizationHeadMobileNoTextKey'),
        keyboardType: TextInputType.phone,
        controller: _orgHeadPhoneTextController,
        validator: Validator().validateNullablePhoneNumber,
        labelText: StringResources.companyOrganizationHeadMobileNoText,
      ),
      spaceBetween,
    ],
  );
  Widget otherInfo ()=> Column(
    children: [
      spaceBetween,
      Text(
        StringResources.companyOtherInformationText,
        style: labelStyle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('basisMembershipTextfieldKey'),
        keyboardType: TextInputType.number,
        //focusNode: _fatherNameFocusNode,
//                    textInputAction: TextInputAction.next,
        onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_motherNameFocusNode);
        },
        controller: _basisMembershipNoTextController,
        labelText: StringResources.companyBasisMembershipNoText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('nameInGoogleTextfieldKey'),
        controller: _companyGoogleTextController,
        labelText: StringResources.nameInGoogle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('nameInBdJobsTextfieldKey'),
        controller: _companyBdJobsTextController,
        labelText: StringResources.nameInBdJobs,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('nameInFacebookTextfieldKey'),
        controller: _companyFacebookTextController,
        labelText: StringResources.nameInFacebook,
      ),
      spaceBetween,
    ],
  );
  Widget contactPerson ()=> Column(
    children: [
      spaceBetween,
      Text(
        StringResources.companyContactPersonSectionText,
        style: labelStyle,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyContactPersonNameTextKey'),
        keyboardType: TextInputType.text,
        isRequired: true,
        controller: _contactPersonNameTextController,
        hintText: StringResources.fullNameHintText,
        labelText: StringResources.companyContactPersonNameText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyContactPersonDesignationTextKey'),
        keyboardType: TextInputType.text,
        isRequired: true,
        controller: _contactPersonDesignationTextController,
        hintText: StringResources.designationHintText,
        labelText: StringResources.companyContactPersonDesignationText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyContactPersonMobileNoTextKey'),
        validator: Validator().validateNullablePhoneNumber,
        keyboardType: TextInputType.phone,
        controller: _contactPersonPhoneTextController,
        hintText: StringResources.phoneHintText,
        labelText: StringResources.companyContactPersonMobileNoText,
      ),
      spaceBetween,
      CustomTextFormField(
        textFieldKey: Key('companyContactPersonEmailTextKey'),
        validator: Validator().validateEmail,
        keyboardType: TextInputType.emailAddress,
        controller: _contactPersonEmailTextController,
        hintText: StringResources.emailHintText,
        labelText: StringResources.companyContactPersonEmailText,
      ),
      spaceBetween,
    ],
  );
  Widget setLocation ()=> InkWell(
    onTap: () {
      LatLng po = (latitude != null && longitude != null)
          ? LatLng(latitude, longitude)
          : null;

      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => LocationPicker(
            latLng: po,
            onSaveLocation: (LatLng latLng) {
              latitude = latLng.latitude;
              longitude = latLng.longitude;
              setState(() {});
            },
          )));
    },
    child: CustomTextFormField(
      enabled: false,
      readOnly: true,
      labelText: StringResources.locationText,
      hintText: StringResources.tapToSelectText,
      controller: TextEditingController()
        ..text = "${latitude ?? ""} , ${longitude ?? ""}",
    ),
  );
}
