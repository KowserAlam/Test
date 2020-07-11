import 'package:after_layout/after_layout.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/change_image_profile_widget.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_edit_profile_view_model.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/repositories/country_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
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

class _CompanyEditProfileState extends State<CompanyEditProfile>
    with AfterLayoutMixin {
  Company company;
  CompanyEditProfileViewModel _vm = CompanyEditProfileViewModel();
  var _formKey = GlobalKey<FormState>();
  String profileImageBase64;
  Country selectedCountry;

  var _companyNameTextController = TextEditingController();
  var _companyProfileTextController = TextEditingController();
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
  DateTime yearOfEstablishment;

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
    _companyProfileTextController.text = company.companyProfile;
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
    _orgHeadDesignationTextController.text = company.organizationHeadDesignation;
    _orgHeadPhoneTextController.text = company.organizationHeadNumber;

    if(company.country.isNotEmptyOrNotNull){
    CountryRepository().getCountryObjFromCode(company.country).then((value) {
      selectedCountry = value;
      print(value);
      setState(() {

      });
      });
    }


    super.initState();
  }

  _handleSave() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      var companyVm =
          Provider.of<CompanyProfileViewModel>(context, listen: false);
      var data = {
        "year_of_eastablishment": yearOfEstablishment?.toYYYMMDDString,
        "legal_structure_of_this_company": _legalStructureTextController.text,
        "company_profile": _companyProfileTextController.text,
        "basis_membership_no": _basisMembershipNoTextController.text,
        "address": _addressTextController.text,
        "city": _cityTextController.text,
        "country": selectedCountry?.code??"",
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
        "total_number_of_human_resources": _noOfHumanResourceTextController.text,
        "no_of_it_resources": _noOfITResourceTextController.text,

      };
      Logger().i(data);

      if (profileImageBase64 != null) {
        data.addAll({"profile_picture": profileImageBase64});
      }
      var res = await companyVm.updateCompany(data);
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
                profileImageBase64 = v;
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
            CustomTextFormField(
              //focusNode: _fatherNameFocusNode,
//                    textInputAction: TextInputAction.next,
              onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_motherNameFocusNode);
              },
              controller: _companyProfileTextController,
              labelText: StringResources.companyProfileText,
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
              onChanged: (v){
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
              labelText: StringResources.bdJobsLinkText,
            ),
            spaceBetween,
            CustomTextFormField(
              controller: _companyFacebookTextController,
              labelText: StringResources.facebookLinkText,
            ),
            spaceBetween,
            CustomTextFormField(
              controller: _companyGoogleTextController,
              labelText: StringResources.googleLinkText,
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
              validator: Validator().integerNumberValidator,
              keyboardType: TextInputType.number,
              controller: _noOfHumanResourceTextController,
              labelText: StringResources.companyNoOFHumanResourcesText,
            ),
            spaceBetween,
            CustomTextFormField(
              validator: Validator().integerNumberValidator,
              keyboardType: TextInputType.number,
              controller: _noOfITResourceTextController,
              labelText: StringResources.companyNoOFItResourcesText,
            ),
            spaceBetween,
          ],
        );

        return Scaffold(
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
                      otherInfo,
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
