import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';
import 'package:ConsumerApp/src/core/models/app_settings.dart';
import 'package:ConsumerApp/src/core/services/app_settings/i_app_settings_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';

class AppSettingsService extends IAppSettingsService {
  final IRestClient _restClient;

  AppSettingsService(this._restClient);
  @override
  Future<AppSettings> getAppSettings() async {
    final response = await _restClient.get(ApiPaths.appSettings);
    if (response.success) {
      return appSettingsFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }
}
