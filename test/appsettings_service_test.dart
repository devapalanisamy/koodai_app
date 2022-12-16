import 'package:ConsumerApp/src/core/configs/app_config.dart';
import 'package:ConsumerApp/src/core/services/app_settings/app_settings_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/rest_client.dart';
import 'package:ConsumerApp/src/core/services/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

main() {
  test('test app settings', () async {
    final service = AppSettingsService(
      RestClient(
        Client(),
        AppConfig(
          baseUrl: 'demo-koodai-api.cbedigital.co.uk',
        ),
        StorageService(),
      ),
    );
    final response = await service.getAppSettings();
    print(response);
  });
}
