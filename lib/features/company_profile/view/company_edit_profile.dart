import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/change_image_profile_widget.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/location_picker.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_edit_profile_view_model.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/repositories/country_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/pick_location_on_map_widget.dart';
import 'package:jobxprss_company/method_extension.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CompanyEditProfile extends StatefulWidget {
  final Company company;

  CompanyEditProfile(this.company);

  @override
  _CompanyEditProfileState createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile>
    with AfterLayoutMixin {
  Company company;
  CompanyEditProfileViewModel _vm = CompanyEditProfileViewModel();
  var _formKey = GlobalKey<FormState>();
  File profileImage;
  Country selectedCountry;
  double latitude;
  double longitude;

  var _companyNameTextController = TextEditingController();
  ZefyrController _companyProfileTextController = ZefyrController(NotusDocument());
  var _legalStructureTextController = TextEditingController();
  var _noOfHumanResourceTextController = TextEditingController();
  var _noOfITResourceTextController = TextEditingController();
  var _basisMembershipNoTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _cityTextController = TextEditingController();
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

  @override
  void afterFirstLayout(BuildContext context) {
    _vm.getCountryList();
  }

  @override
  void initState() {
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
    _cityTextController.text = company.district;
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

    if (company.country.isNotEmptyOrNotNull) {
      CountryRepository().getCountryObjFromCode(company.country).then((value) {
        selectedCountry = value;
        logger.i(value);
        setState(() {});
      });
    }

    super.initState();
  }

  _handleSave() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      var companyVm =
          Provider.of<CompanyProfileViewModel>(context, listen: false);
      Map<String, dynamic> data = {
        "year_of_eastablishment": yearOfEstablishment?.toYYYMMDDString,
        "legal_structure_of_this_company": _legalStructureTextController.text,
        "company_profile": _companyProfileTextController.document.toHTML.getStringInNotNull,
        "basis_membership_no": _basisMembershipNoTextController.text,
        "address": _addressTextController.text,
        "city": _cityTextController.text,
        "country": selectedCountry?.code ?? "",
        "company_contact_no_one": _contactNo1TextController.text,
        "company_contact_no_two": _contactNo2TextController.text,
        "company_contact_no_three": _contactNo3TextController.text,
        "email": _emailTextController.text,
        "web_address": _webAddressTextController.text,
        "company_name_bdjobs": _companyBdJobsTextController.text,
        "company_name_facebook": _companyFacebookTextController.text,
        "company_name_google": _companyGoogleTextController.text,
        "organization_head": _orgHeadNameTextController.text,
        "organization_head_designation": _orgHeadDesignationTextController.text,
        "organization_head_number": _orgHeadPhoneTextController.text,
        "total_number_of_human_resources":
            _noOfHumanResourceTextController.text,
        "no_of_it_resources": _noOfITResourceTextController.text,
        "contact_person": _contactPersonNameTextController.text,
        "contact_person_designation":
            _contactPersonDesignationTextController.text,
        "contact_person_mobile_no": _contactPersonPhoneTextController.text,
        "contact_person_email": _contactPersonEmailTextController.text,
        "latitude": latitude.toStringAsFixed(8) ?? "",
        "longitude": longitude.toStringAsFixed(8) ?? "",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(context).textTheme.subtitle1;

    return ChangeNotifierProvider(
      create: (context) => _vm,
      child: Consumer<CompanyEditProfileViewModel>(
          builder: (context, editProfileVm, child) {
        var header = Column(
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
              labelText: StringResources.nameText,
              hintText: StringResources.companyNameHint,
            ),
            spaceBetween,
          ],
        );
        var basicInfo = Column(
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
              hintText: StringResources.companyProfileText,
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
            ),
            //Legal Structure
            spaceBetween,
            CustomTextFormField(
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
          ],
        );
        var address = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.companyAddressSectionText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 8,
              controller: _addressTextController,
              labelText: StringResources.addressText,
              hintText: StringResources.addressHintText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _cityTextController,
              labelText: StringResources.companyCityText,
              hintText: StringResources.companyCityEg,
            ),
            spaceBetween,
            CustomDropdownSearchFormField<Country>(
              labelText: StringResources.companyCountryText,
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
            ),
          ],
        );

        var contact = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.contactText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              validator: Validator().validatePhoneNumber,
              hintText: StringResources.phoneHintText,
              controller: _contactNo1TextController,
              labelText: StringResources.contactNoOneText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              validator: Validator().validatePhoneNumber,
              hintText: StringResources.phoneHintText,
              controller: _contactNo2TextController,
              labelText: StringResources.contactNoTwoText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              validator: Validator().validatePhoneNumber,
              hintText: StringResources.phoneHintText,
              controller: _contactNo3TextController,
              labelText: StringResources.contactNoThreeText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().validateEmail,
              hintText: StringResources.emailHintText,
              controller: _emailTextController,
              labelText: StringResources.emailText,
            ),
            spaceBetween,
            CustomTextFormField(
              hintText: StringResources.webAddressHintText,
              controller: _webAddressTextController,
              labelText: StringResources.companyWebAddressText,
            ),
            spaceBetween,
          ],
        );
        var socialNetwork = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.companySocialNetworksSectionText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              controller: _companyBdJobsTextController,
              labelText: StringResources.nameInBdJobs,
            ),
            spaceBetween,
            CustomTextFormField(
              controller: _companyFacebookTextController,
              labelText: StringResources.nameInFacebook,
            ),
            spaceBetween,
            CustomTextFormField(
              controller: _companyGoogleTextController,
              labelText: StringResources.nameInGoogle,
            ),
            spaceBetween,
          ],
        );
        var orgHead = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.companyOrganizationHeadSectionText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _orgHeadNameTextController,
              labelText: StringResources.companyOrganizationHeadNameText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _orgHeadDesignationTextController,
              labelText: StringResources.companyOrganizationHeadDesignationText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              controller: _orgHeadPhoneTextController,
              validator: Validator().validateNullablePhoneNumber,
              labelText: StringResources.companyOrganizationHeadMobileNoText,
            ),
            spaceBetween,
          ],
        );
        var otherInfo = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.companyOtherInformationText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _legalStructureTextController,
              labelText: StringResources.legalStructureText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().integerNumberNullableValidator,
              keyboardType: TextInputType.number,
              controller: _noOfHumanResourceTextController,
              labelText: StringResources.companyNoOFHumanResourcesText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().integerNumberNullableValidator,
              keyboardType: TextInputType.number,
              controller: _noOfITResourceTextController,
              labelText: StringResources.companyNoOFItResourcesText,
            ),
            spaceBetween,
          ],
        );
        var contactPerson = Column(
          children: [
            spaceBetween,
            Text(
              StringResources.companyContactPersonSectionText,
              style: labelStyle,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _contactPersonNameTextController,
              hintText: StringResources.fullNameHintText,
              labelText: StringResources.companyContactPersonNameText,
            ),
            spaceBetween,
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: _contactPersonDesignationTextController,
              hintText: StringResources.designationHintText,
              labelText: StringResources.companyContactPersonDesignationText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().validateNullablePhoneNumber,
              keyboardType: TextInputType.phone,
              controller: _contactPersonPhoneTextController,
              hintText: StringResources.phoneHintText,
              labelText: StringResources.companyContactPersonMobileNoText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().validateEmail,
              keyboardType: TextInputType.emailAddress,
              controller: _contactPersonEmailTextController,
              hintText: StringResources.emailHintText,
              labelText: StringResources.companyContactPersonEmailText,
            ),
            spaceBetween,
          ],
        );

        var setLocation = InkWell(
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

        return ZefyrScaffold(
          child: Scaffold(
            appBar: AppBar(
              title: Text(StringResources.updateInfoText),
              actions: [
                EditScreenSaveButton(
                  text: StringResources.saveText,
                  onPressed: _handleSave,
                )
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        header,
                        basicInfo,
                        address,
                        contact,
                        socialNetwork,
                        orgHead,
                        contactPerson,
                        otherInfo,
                        setLocation,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
