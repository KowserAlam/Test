import 'package:get_it/get_it.dart';
import 'package:jobxprss_company/features/settings/settings_view_model.dart';
import 'package:jobxprss_company/main_app/views/widgets/restart_widget.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
//  locator.registerFactory(() => PushNotificationService());
  locator.registerLazySingleton<RestartNotifier>(() => RestartNotifier());
  locator.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel());
}