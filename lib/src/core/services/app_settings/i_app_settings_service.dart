import 'package:ConsumerApp/src/core/models/app_settings.dart';

abstract class IAppSettingsService {
  Future<AppSettings> getAppSettings();
}
