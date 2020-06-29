import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';

class CompanyProfileViewModel with ChangeNotifier {
  Company _company;

  Future<Company> getCompanyDetails() async {
    return company = await CompanyRepository().getCompanyFromLocalStorage();
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
    notifyListeners();
  }

  Future<bool> updateCompany(Map<String, dynamic> data) async {
    BotToast.showLoading();
    var res = await CompanyRepository().updateCompany(data);
    if (res) {
      BotToast.closeAllLoading();
      // this for temporary .. will be replaced latter
      var name =
          await AuthService.getInstance().then((value) => value.getUser().cId);
      CompanyRepository().getCompanyFromServer(name).then((value) {
        getCompanyDetails();
      });
    }else{
      BotToast.closeAllLoading();
    }
    return res;
  }
}
