import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/manage_job_repository.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class ManageJobViewModel with ChangeNotifier {
  List<JobListModel> _jobList = [];
  bool _isFetchingData = false;
  bool _isFetchingMoreData = false;
  bool _hasMoreData = false;
  int _pageCount = 1;
  bool _isInSearchMode = false;
  int _totalJobCount = 0;
  AppError _appError;
  DateTime _lastFetchTime;

  Future<bool> getJobList({bool isFormOnPageLoad = false}) async {
    _totalJobCount = 0;
    _appError = null;

    _pageCount = 1;
    _isFetchingData = true;
    notifyListeners();

    Either<AppError, ManageJobListScreenDataModel> result =
        await ManageJobRepository().getJobList();
    return result.fold((l) {
      _hasMoreData = false;
      _isFetchingData = false;
      _totalJobCount = 0;
      _appError = l;
      notifyListeners();
      logger.i(l);
      return false;
    }, (ManageJobListScreenDataModel dataModel) {
      _lastFetchTime = DateTime.now();
      var list = dataModel.jobList;
      _isFetchingData = false;
      _jobList = list;
      _totalJobCount = dataModel.count;
      _hasMoreData = dataModel.nextPage;
      _appError = null;
      notifyListeners();
      return true;
    });
  }

  void incrementPageCount() {
    _pageCount++;
  }

  getMoreData() async {
    if (!_isFetchingData && !_isFetchingMoreData && _hasMoreData) {
      isFetchingMoreData = true;
      debugPrint('Getting more jobs');
      hasMoreData = true;
      incrementPageCount();
      Either<AppError, ManageJobListScreenDataModel> result =
          await ManageJobRepository().getJobList(page: _pageCount);
      result.fold((l) {
        _isFetchingMoreData = false;
        _hasMoreData = false;
        _totalJobCount = 0;
        notifyListeners();

        logger.i(l);
      }, (ManageJobListScreenDataModel dataModel) {
        // right
        var list = dataModel.jobList;
        _totalJobCount = dataModel.count;
        _hasMoreData = dataModel.nextPage;
        _jobList.addAll(list);
        _isFetchingMoreData = false;
        notifyListeners();
      });
    }
  }

  Future<bool> refresh() {
    _pageCount = 0;
    return getJobList();
  }

  Future<bool> changeJobStatus(JobStatus jobStatus, String jid,int index) async {

    _getUrl(){
      switch(jobStatus){

        case JobStatus.DRAFT:
          return "";
          break;
        case JobStatus.PUBLISHED:
          return "${Urls.jobMakeUnPublishUrl}$jid/";
          break;
        case JobStatus.POSTED:
          return "${Urls.jobMakeUnPostUrl}$jid/";
          break;
        case JobStatus.UNPUBLISHED:
          return "${Urls.jobMakeUnpublishUrl}$jid/";
          break;
      }
    }



    try {
      BotToast.showLoading();
      var data = {"":""};

      var url = _getUrl();

      var res = await ApiClient().putRequest(url, data);
      logger.i(url);
      logger.i(res.statusCode);
      logger.i(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        jobList[index].jobStatus = jobStatus;
        notifyListeners();

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

  bool get showError => _appError != null && _jobList.length == 0;

  bool get showLoader => _jobList.length == 0 && _isFetchingData;

  DateTime get lastFetchTime => _lastFetchTime;

  set lastFetchTime(DateTime value) {
    _lastFetchTime = value;
    notifyListeners();
  }

  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
    notifyListeners();
  }

  int get totalJobCount => _totalJobCount;

  set totalJobCount(int value) {
    _totalJobCount = value;
    notifyListeners();
  }

  bool get isInSearchMode => _isInSearchMode;

  set isInSearchMode(bool value) {
    _isInSearchMode = value;
    notifyListeners();
  }

  int get pageCount => _pageCount;

  set pageCount(int value) {
    _pageCount = value;
    notifyListeners();
  }

  bool get hasMoreData => _hasMoreData;

  set hasMoreData(bool value) {
    _hasMoreData = value;
    notifyListeners();
  }

  bool get isFetchingMoreData => _isFetchingMoreData;

  set isFetchingMoreData(bool value) {
    _isFetchingMoreData = value;
    notifyListeners();
  }

  bool get isFetchingData => _isFetchingData;

  set isFetchingData(bool value) {
    _isFetchingData = value;
    notifyListeners();
  }

  List<JobListModel> get jobList => _jobList;

  set jobList(List<JobListModel> value) {
    _jobList = value;
    notifyListeners();
  }
}
