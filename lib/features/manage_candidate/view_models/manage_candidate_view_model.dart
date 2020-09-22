import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/features/manage_candidate/repositories/manage_candidate_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';

class ManageCandidateVewModel extends GetxController {
  var candidates = <Candidate>[].obs;
  var _isFetchingData = false.obs;
  var _appError = AppError.none.obs;
  String _jobId;


  Future<bool> getData(String jobId) async {
    _jobId = jobId;
    _isFetchingData.value = true;
    _appError.value = AppError.none;

    var res = await ManageCandidateRepository().getCandidateList(jobId);
    return res.fold((AppError l) {
      _appError.value = l;
      _isFetchingData.value = false;

      return false;
    }, (ManageCandidateListDataModel r) {
      candidates.value = r.candidates;
      _isFetchingData.value = false;

      return true;
    });
  }


  Future<bool>refresh(){
    return getData(_jobId);
  }


  bool get showError => _appError.value != AppError.none && candidates.length == 0;

  bool get showLoader => candidates.length == 0 && _isFetchingData.value;

  AppError get appError => _appError.value;
}
