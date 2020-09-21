import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/repositories/job_categories_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_experience_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_gender_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_nature_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_qualification_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_site_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_type_list_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class JobPostViewModel with ChangeNotifier {
  List<String> _genderList = [];
  List<String> _experienceList = [];
  List<String> _qualifications = [];
  List<String> _jobCategoryList = [];
  List<JobSite> _jobSiteList = [];
  List<JobType> _jobTypeList = [];
  List<JobNature> _jobNatureList = [];

  getData() {
    _getJobGenders();
    _getCategoryList();
    _getJobExperiences();
    _getJobQualifications();
    _getJobSiteList();
    _getJobNatureList();
    _getJobTypeList();
  }

  Future<bool> postNewJob(Map<String, dynamic> data) async {
    try {
      BotToast.showLoading();

      data.removeWhere((key, value) => value == null);
      // logger.i(data);
      var res = await ApiClient().postRequest(Urls.postNewJobUrl, data);
      // logger.i(res.statusCode);
      logger.i(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        return true;
      } else {
        BotToast.closeAllLoading();
Get.back();
        return false;
      }
    } on SocketException catch (e) {
      BotToast.showText(text: StringResources.couldNotReachServer);
      logger.e(e);
      BotToast.closeAllLoading();
      return false;
    } catch (e) {
      logger.e(e);
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.somethingIsWrong);
      return false;
    }
  }

  Future<bool> updateJob(Map<String, dynamic> data, String jid) async {
    try {
      BotToast.showLoading();

      // Map<String, dynamic> body = await AuthService.getInstance().then((value) {
      //   data.addAll({"company_id": value.getUser().name});
      //   return data;
      // });

      data.removeWhere((key, value) => value == null);
      // var cid = await AuthService.getInstance().then((value)=>value.getUser().name);

      var url = "${Urls.updateJobUrl}$jid/";

      var res = await ApiClient().putRequest(url, data);
      logger.i(res.statusCode);
      logger.i(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        Get.back();
        return true;
      } else {
        BotToast.closeAllLoading();
        return false;
      }
    } on SocketException catch (e) {
      BotToast.showText(text: StringResources.couldNotReachServer);
      logger.e(e);
      BotToast.closeAllLoading();
      return false;
    } catch (e) {
      logger.e(e);
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

  _getJobExperiences() async {
    var res = await JobExperienceListRepository().getList();
    res.fold((l) {}, (r) {
      _experienceList = r;
      notifyListeners();
    });
  }

  _getJobQualifications() async {
    var res = await JobQualificationListRepository().getList();
    res.fold((l) {}, (r) {
      _qualifications = r;
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

  _getJobSiteList() async {
    var res = await JobSiteListRepository().getList();
    res.fold((l) {}, (r) {
      _jobSiteList = r;
      notifyListeners();
    });
  }

  _getJobTypeList() async {
    var res = await JobTypeListRepository().getList();
    res.fold((l) {}, (r) {
      _jobTypeList = r;
      notifyListeners();
    });
  }

  _getJobNatureList() async {
    var res = await JobNatureListRepository().getList();
    res.fold((l) {}, (r) {
      _jobNatureList = r;
      notifyListeners();
    });
  }

  List<String> get genderList => _genderList;

  List<String> get experienceList => _experienceList;

  List<String> get jobCategoryList => _jobCategoryList;

  List<String> get qualifications => _qualifications;

  List<JobSite> get jobSiteList => _jobSiteList;

  List<JobNature> get jobNature => _jobNatureList;

  List<JobType> get jobType => _jobTypeList;
}
