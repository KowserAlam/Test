 import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/features/manage_candidate/repositories/manage_candidate_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';

class ManageCandidateVewModel with ChangeNotifier{
  List<Candidate> _candidates = [];
  
  getData(String jobId)async{
   var res = await ManageCandidateRepository().getCandidateList(jobId);
   res.fold((AppError l) => null, (ManageCandidateListDataModel r) {
     _candidates = r.candidates;
     notifyListeners();
   });
  }

  List<Candidate> get candidates => _candidates;

  set candidates(List<Candidate> value) {
    _candidates = value;
    notifyListeners();
  }
}