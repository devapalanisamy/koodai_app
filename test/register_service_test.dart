import 'package:ConsumerApp/src/core/configs/app_config.dart';
import 'package:ConsumerApp/src/core/models/login_request.dart';
import 'package:ConsumerApp/src/core/models/new_user.dart';
import 'package:ConsumerApp/src/core/services/authentication/authentication_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/rest_client.dart';
import 'package:ConsumerApp/src/core/services/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

main() {
  test('test register', () async {
    final service = AuthenticationService(
      RestClient(
        Client(),
        AppConfig(
          baseUrl: 'demo-koodai-api.cbedigital.co.uk',
        ),
        StorageService(),
      ),
      StorageService(),
    );
    final response = await service.registerNewUser(NewUser(
        firstName: 'test1',
        lastName: 'test2',
        phone: '021341234123',
        email: 'heee@gmai.com',
        password: 'AF34234@£1'));
    print(response);
  });

  test('test login', () async {
    final service = AuthenticationService(
        RestClient(
          Client(),
          AppConfig(
            baseUrl: 'demo-koodai-api.cbedigital.co.uk',
          ),
          StorageService(),
        ),
        StorageService());
    final response = await service.login(
      LoginRequest(userName: 'heee@gmai.com', password: 'AF34234@£1'),
    );
    print(response);
  });
}
