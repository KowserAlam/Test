import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/features/manage_candidate/repositories/manage_candidate_repository.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class ManageCandidateVewModel extends GetxController {
  var candidates = <Candidate>[].obs;
  var candidatesShortlisted = <Candidate>[].obs;
  var _isFetchingData = false.obs;
  var _appError = AppError.none.obs;

  Future<bool> getData(String jobId) async {
    _isFetchingData.value = true;
    _appError.value = AppError.none;


    var res = await ManageCandidateRepository().getCandidateList(jobId);
    return res.fold((AppError l) {
      _appError.value = l;
      _isFetchingData.value = false;
      candidatesShortlisted.clear();

      return false;
    }, (ManageCandidateListDataModel r) {
      candidates.value = r.candidates;
      for(int i=0; i<= r.candidates.length; i++){
        if(candidates[i].isShortlisted){
          candidatesShortlisted.add(r.candidates[i]);
        }
      }
      _isFetchingData.value = false;

      return true;
    });
  }

  List<Candidate> toggleShortListed(bool isShortListed){
    if(isShortListed){
      return candidatesShortlisted;
    }else{
      return candidates;
    }
  }

  Future<bool> refresh(String jobID) {
    return getData(jobID);
  }

  bool get showError =>
      _appError.value != AppError.none && candidates.length == 0;

  bool get showLoader => candidates.length == 0 && _isFetchingData.value;

  AppError get appError => _appError.value;

 Future toggleCandidateShortlistedStatus(String id, int index) async{
    var url = "${Urls.toggleCandidateShortlistedStatusUrl}$id/";

    bool isShortlisted = !candidates[index].isShortlisted;
    var body = {
      "is_shortlisted": isShortlisted,
    };
    try {
      var res = await ApiClient().putRequest(url, body);
      logger.i(res.statusCode);
      logger.i(res.body);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        isShortlisted = decodedJson["is_shortlisted"]??false;
        candidates[index].isShortlisted = isShortlisted;
        candidates.value = candidates.toList();


        return true;
      }else{
        return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
