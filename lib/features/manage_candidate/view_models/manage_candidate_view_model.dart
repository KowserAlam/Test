import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/features/manage_candidate/repositories/manage_candidate_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';

class ManageCandidateVewModel with ChangeNotifier {
  List<Candidate> _candidates = [];
  bool _isFetchingData = false;
  AppError _appError;
  String _jobId;


  Future<bool> getData(String jobId) async {
    _jobId = jobId;
    _isFetchingData = true;
    _appError = null;
    notifyListeners();
    var res = await ManageCandidateRepository().getCandidateList(jobId);
    return res.fold((AppError l) {
      _appError = l;
      _isFetchingData = false;
      notifyListeners();
      return false;
    }, (ManageCandidateListDataModel r) {
      _candidates = r.candidates;
      _isFetchingData = false;
      notifyListeners();
      return true;
    });
  }


  Future<bool>refresh(){
    return getData(_jobId);
  }

  List<Candidate> get candidates => _candidates;

  set candidates(List<Candidate> value) {
    _candidates = value;
    notifyListeners();
  }

  bool get showError => _appError != null && _candidates.length == 0;

  bool get showLoader => _candidates.length == 0 && _isFetchingData;

  AppError get appError => _appError;
}
