import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/manage_job_repository.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class ManageJobViewModel extends GetxController {
  var jobList = <JobListModel>[].obs;
  var isFetchingData = false.obs;
  var isFetchingMoreData = false.obs;
  var hasMoreData = false.obs;
  int _pageCount = 1;
  var _isInSearchMode = false.obs;
  var totalJobCount = 0.obs;
  var appError = AppError.none.obs;

  Future<bool> getJobList({pageSize = 15}) async {
    totalJobCount.value = 0;
    appError.value = AppError.none;
    _pageCount = 1;
    isFetchingData.value = true;

    Either<AppError, ManageJobListScreenDataModel> result =
        await ManageJobRepository().getJobList(pageSize:pageSize);
    return result.fold((l) {
      hasMoreData.value = false;
      isFetchingData.value = false;
      totalJobCount.value = 0;
      appError.value = l;

      logger.i(l);
      return false;
    }, (ManageJobListScreenDataModel dataModel) {
      var list = dataModel.jobList;
      isFetchingData.value = false;
      jobList.value = list;
      totalJobCount.value = dataModel.count;
      hasMoreData.value = dataModel.nextPage;
      appError.value = AppError.none;
      return true;
    });
  }

  void incrementPageCount() {
    _pageCount++;
  }

  getMoreData() async {
    if (!isFetchingData.value &&
        !isFetchingMoreData.value &&
        hasMoreData.value) {
      isFetchingMoreData.value = true;
      debugPrint('Getting more jobs');
      hasMoreData.value = true;
      incrementPageCount();
      Either<AppError, ManageJobListScreenDataModel> result =
          await ManageJobRepository().getJobList(page: _pageCount);
      result.fold((l) {
        isFetchingMoreData.value = false;
        hasMoreData.value = false;
        totalJobCount.value = 0;

        logger.i(l);
      }, (ManageJobListScreenDataModel dataModel) {
        // right
        var list = dataModel.jobList;
        totalJobCount.value = dataModel.count;
        hasMoreData.value = dataModel.nextPage;
        jobList.addAll(list);
        isFetchingMoreData.value = false;
      });
    }
  }

  Future<bool> refresh() {
    _pageCount = 0;
    return getJobList();
  }

  Future<bool> changeJobStatus(
      JobStatus jobStatus, String jid, int index) async {
    _getUrl() {
      switch (jobStatus) {
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
      var data = {"": ""};

      var url = _getUrl();

      var res = await ApiClient().putRequest(url, data);
      logger.i(url);
      logger.i(res.statusCode);
      logger.i(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        jobList[index].jobStatus = jobStatus;
        jobList.value = jobList.toList();

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

  bool get showError => appError.value != AppError.none && jobList.length == 0;

  bool get showLoader => jobList.length == 0 && isFetchingData.value;
}
