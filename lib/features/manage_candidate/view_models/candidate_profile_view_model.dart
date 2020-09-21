import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/models/candidate_model.dart';
import 'package:jobxprss_company/features/manage_candidate/repositories/manage_candidate_repository.dart';
import 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';

class CandidateProfileViewModel extends GetxController {
  var isBusyLoading = false.obs;
  var appError = AppError.none.obs;

  var candidate = CandidateModel().obs;


  Future<bool> getCandidateInfo(String slug) async {
    isBusyLoading.value = true;
    appError.value = AppError.none;
    var result = await ManageCandidateRepository().getCandidateProfile(slug);
    return result.fold((left) {
      isBusyLoading.value = false;
      appError.value = left;
      return false;
    }, (right) {
      /// if right
      candidate.value = right;
      appError.value = AppError.none;
      isBusyLoading.value = false;
      return true;
    });
  }
}
