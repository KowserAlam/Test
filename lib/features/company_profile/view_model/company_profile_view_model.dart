import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class CompanyProfileViewModel extends GetxController {
  Company _company;
  bool _isLoading = false;
  AppError _appError;


  @override
  void onInit() {
    getCompanyDetails();
    super.onInit();
  }

  Future<bool> getCompanyDetails() async {
    _appError = null;
    _isLoading = true;
    update();
    var res = await CompanyRepository().getCompanyFromServer();

    return res.fold((l) {
      _appError = l;
      _isLoading = false;
      update();
      return true;
    }, (r) {
      _company = r;
      _isLoading = false;
      update();
      return false;
    });
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
    update();
  }

  Future<bool> refresh() {
    return getCompanyDetails();
  }

  Future<bool> updateCompany(Map<String, dynamic> data,
      {File imageFile}) async {

    // data.removeWhere((key, value) => value == null);
    BotToast.showLoading();
    Future<bool> res = CompanyRepository().updateInfo(data);
    if (await res) {
      BotToast.closeAllLoading();
      // this for temporary .. will be replaced latter
      refresh();
    } else {
      BotToast.showText(text: StringResources.unableToSave);
      BotToast.closeAllLoading();
    }
    return res;
  }

  bool get showApError => _company == null && _appError != null;

  bool get showLoading => _company == null && _isLoading;

  AppError get appError => _appError;
}
