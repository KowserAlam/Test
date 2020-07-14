import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/repositories/job_categories_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_gender_list_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class JobPostViewModel with ChangeNotifier {
  List<String> _genderList = [];
  List<String> _jobCategoryList = [];



  getData() {
    _getJobGenders();
    _getCategoryList();
  }

  Future<bool> postNewJob(Map<String, dynamic> data) async {
    try {
      BotToast.showLoading();
      Map<String, dynamic> body = await AuthService.getInstance().then((value) {
        data.addAll({"company_id": value.getUser().name});
        return data;
      });

      var res = await ApiClient().postRequest(Urls.postNewJobUrl, body);
      print(res.statusCode);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        return true;
      } else {
        BotToast.closeAllLoading();
        return false;
      }
    } on SocketException catch (e) {
      BotToast.showText(text: StringResources.couldNotReachServer);
      print(e);
      BotToast.closeAllLoading();
      return false;
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.somethingIsWrong);
      return false;
    }
  }

  _getJobGenders() async {
    var res = await JobGenderListRepository().getList();
    res.fold((l) {}, (r) {
      _genderList = r;
      notifyListeners();
    });

  }
  _getCategoryList() async {
    var res = await JobCategoriesLisRepository().getList();
    res.fold((l) {}, (r) {
      _jobCategoryList = r;
      notifyListeners();
    });
  }
  List<String> get genderList => _genderList;
  List<String> get jobCategoryList => _jobCategoryList;
}