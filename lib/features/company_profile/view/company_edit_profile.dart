import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';
import 'package:jobxprss_company/features/company_profile/view/widgets/change_image_profile_widget.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:jobxprss_company/method_extension.dart';
import 'package:provider/provider.dart';

class CompanyEditProfile extends StatefulWidget {
  final Company company;

  CompanyEditProfile(this.company);

  @override
  _CompanyEditProfileState createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  Company company;
  var _formKey = GlobalKey<FormState>();
  String profileImageBase64;

  var _companyNameTextController = TextEditingController();
  var _companyProfileTextController = TextEditingController();
  var _legalStructureTextController = TextEditingController();
  var _basisMembershipNoTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _districtTextController = TextEditingController();
  var _postCodeTextController = TextEditingController();
  DateTime yearOfEstablishment;

  var spaceBetween = SizedBox(
    height: 10,
  );

  @override
  void initState() {
    company = widget.company;

    _companyNameTextController.text = company.name;
    _companyProfileTextController.text = company.companyProfile;
    yearOfEstablishment = company.yearOfEstablishment;
    _legalStructureTextController.text = company.legalStructure;
    _basisMembershipNoTextController.text = company.basisMembershipNo;
    _addressTextController.text = company.address;
    _districtTextController.text = company.district;
    _postCodeTextController.text = company.postCode;

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
        "district": _districtTextController.text,
        "post_code": _postCodeTextController.text,
      };

      if(profileImageBase64 != null){
        data.addAll({
          "profile_picture":profileImageBase64
        });
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

    var header = Column(
      children: [
        spaceBetween,
        ChangeProfileImage(onImageSelect: (v){
          profileImageBase64 = v;
        },),
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
          keyboardType: TextInputType.text,
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
          minLines: 3,maxLines: 8,
          controller: _addressTextController,
          labelText: StringResources.addressText,
          hintText: StringResources.addressHintText,
        ),
        spaceBetween,
        CustomTextFormField(
          keyboardType: TextInputType.text,
          controller: _districtTextController,
          labelText: StringResources.companyDistrictText,
          hintText: StringResources.companyDistrictText,
        ),
        spaceBetween,
        CustomTextFormField(
          keyboardType: TextInputType.text,
          controller: _postCodeTextController,
          labelText: StringResources.companyPostCodeText,
          hintText: StringResources.companyPostCodeText,
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
          //focusNode: _fatherNameFocusNode,
//                    textInputAction: TextInputAction.next,
          onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_motherNameFocusNode);
          },
          controller: _legalStructureTextController,
          labelText: StringResources.legalStructureText,
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
                  otherInfo,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
