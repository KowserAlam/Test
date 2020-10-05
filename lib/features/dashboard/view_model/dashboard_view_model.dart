import 'package:get/get.dart';
import 'package:jobxprss_company/features/dashboard/models/info_box_data_model.dart';
import 'package:jobxprss_company/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:jobxprss_company/features/dashboard/repositories/dashboard_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';

class DashboardViewModel extends GetxController {
  AppError _infoBoxError;
  AppError _skillJobChartError;
  InfoBoxDataModel _infoBoxData;
  List<SkillJobChartDataModel> _skillJobChartData = [];
  bool _isLoadingInfoBoxData = false;
  bool _isLoadingSkillJobChartData = false;

  Future<AppError> getDashboardData() async {
    _isLoadingInfoBoxData = true;
    _isLoadingSkillJobChartData = true;
    _infoBoxError = null;
    _skillJobChartError = null;
    update();
    return Future.wait([
      _getInfoBoxData(),
      _getISkillJobChartData(),
//      _getProfileCompleteness(),
    ]).then((value) {
      return _infoBoxError;
    });
  }

  Future<bool> _getInfoBoxData() async {
    var result = await DashBoardRepository().getInfoBoxData();

    return result.fold((l) {
      _infoBoxError = l;
      _isLoadingInfoBoxData = false;
      update();
      return false;
    }, (r) {
      _infoBoxData = r;
      _isLoadingInfoBoxData = false;
      update();
      return true;
    });
  }

  Future<bool> _getISkillJobChartData() async {
    var result = await DashBoardRepository().getSkillJobChart();

    return result.fold((l) {
      _skillJobChartError = l;
      _isLoadingSkillJobChartData = false;
      update();
      return false;
    }, (r) {
      _skillJobChartData = r;
      _isLoadingSkillJobChartData = false;
      update();
      return true;
    });
  }

  bool get shouldShowInfoBoxLoader =>
      _isLoadingInfoBoxData && (_infoBoxData == null);

  bool get shouldShowJoChartLoader =>
      _isLoadingSkillJobChartData && (_skillJobChartData.length == 0);

  AppError get infoBoxError => _infoBoxError;

  AppError get skillJobChartError => _skillJobChartError;

  InfoBoxDataModel get infoBoxData => _infoBoxData;

  List<SkillJobChartDataModel> get skillJobChartData => _skillJobChartData;

  bool get isLoadingInfoBoxData => _isLoadingInfoBoxData;

  bool get isLoadingSkillJobChartData => _isLoadingSkillJobChartData;

  bool get shouldShowError => _infoBoxError != null && infoBoxData == null;
}
