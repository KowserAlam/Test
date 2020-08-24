import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/models/company_screen_data_model.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/method_extension.dart';

class CompanyListViewModel with ChangeNotifier {
  List<Company> companyList = [];
  bool _isFetchingData = false;
  bool _isFetchingMoreData = false;
  CompanyRepository _companyListRepository = CompanyRepository();
  String _query;
  int _companiesCount = 0;
  bool isInSearchMode = false;
  bool _hasMoreData;
  int _page = 1;
  AppError _appError;

  AppError get appError => _appError;

  set query(String value) {
    _query = value;
    notifyListeners();
  }

  bool get shouldShowAppError => companyList.length == 0 && _appError != null;

  bool get shouldShowCompanyCount =>
      _query.isNotEmptyOrNotNull && isInSearchMode && !_isFetchingData;

  bool get shouldShowLoader => _isFetchingData && companyList.length == 0;

  Future<bool> getCompanyList() async {
    if (_query.isNotEmptyOrNotNull) {
      companyList = [];
    }
    _appError = null;
    _isFetchingData = true;
    notifyListeners();
    Either<AppError, CompanyScreenDataModel> result =
        await _companyListRepository.getList(query: _query);
    return result.fold((l) {
      _isFetchingData = false;
      logger.i(l);
      _appError = l;
      notifyListeners();
      return false;
    }, (CompanyScreenDataModel dataModel) {
      var list = dataModel.companies;
      logger.i(list.length);
      _companiesCount = dataModel.count;
      companyList = list;
      _isFetchingData = false;
      _hasMoreData = dataModel.next;
      notifyListeners();
      return true;
    });
  }

  getMoreData() async {
    if (_hasMoreData && !_isFetchingMoreData && !_isFetchingData) {
      _appError = null;
      logger.i("Getting more data");
      _page++;
      _isFetchingMoreData = true;
      notifyListeners();

      Either<AppError, CompanyScreenDataModel> result =
          await _companyListRepository.getList(query: _query, page: _page);
      return result.fold((l) {
        _isFetchingMoreData = false;
        _appError = l;
        notifyListeners();
        logger.i(l);
        return false;
      }, (CompanyScreenDataModel dataModel) {
        _companiesCount = dataModel.count;
        companyList.addAll(dataModel.companies);
        _isFetchingMoreData = false;
        _hasMoreData = dataModel.next;
        notifyListeners();
        return true;
      });
    }
  }

  toggleIsInSearchMode() {
    isInSearchMode = !isInSearchMode;
    _page = 1;
    if (!isInSearchMode) {
      _query = null;
      getCompanyList();
    }
    notifyListeners();
  }

  clearSearch() {
    _page = 1;
    _isFetchingData = false;
    _isFetchingMoreData = false;
    isInSearchMode = false;
    _query = "";
  }

  Future<void> refresh() async {
    _page = 0;
    return getCompanyList();
  }

  resetState() {
    companyList = null;
    _isFetchingData = false;
    _isFetchingMoreData = false;
    isInSearchMode = false;
    _companyListRepository = CompanyRepository();
    _companiesCount = 0;
    _query = "";
    _page = 1;
    getCompanyList();
    notifyListeners();
  }

  bool get hasMoreData => _hasMoreData;

  bool get isFetchingData => _isFetchingData;

  int get companiesCount => _companiesCount;

  bool get isFetchingMoreData => _isFetchingMoreData;
}
