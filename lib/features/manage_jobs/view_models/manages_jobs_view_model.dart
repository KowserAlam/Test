import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/job_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';

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

    if (isFormOnPageLoad) {
      bool shouldNotFetchData = CommonServiceRule.instance
          .shouldNotFetchData(_lastFetchTime, _appError);
      if (shouldNotFetchData) return null;
    }

    _isFetchingData = true;
    notifyListeners();

    Either<AppError, JobListScreenDataModel> result =
        await JobRepository().fetchJobList();
    return result.fold((l) {
      _hasMoreData = false;
      _isFetchingData = false;
      _totalJobCount = 0;
      _appError = l;
      notifyListeners();
      print(l);
      return false;
    }, (JobListScreenDataModel dataModel) {
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
      Either<AppError, JobListScreenDataModel> result =
          await JobRepository().fetchJobList();
      result.fold((l) {
        _isFetchingMoreData = false;
        _hasMoreData = false;
        _totalJobCount = 0;
        notifyListeners();

        print(l);
      }, (JobListScreenDataModel dataModel) {
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

  bool get shouldShowAppError => _appError != null && _jobList.length == 0;

  bool get shouldShowPageLoader => _jobList.length == 0 && _isFetchingData;

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
