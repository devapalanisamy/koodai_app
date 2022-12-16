import 'package:ConsumerApp/src/core/configs/app_config.dart';
import 'package:ConsumerApp/src/core/configs/constants.dart';
import 'package:ConsumerApp/src/core/models/login_response.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:ConsumerApp/src/core/services/storage/i_storage_service.dart';
import 'package:http/http.dart';

class RestClient extends IRestClient {
  final Client _client;
  final AppConfig _appConfig;
  final IStorageService _storageService;

  RestClient(this._client, this._appConfig, this._storageService);

  @override
  Future<Response> get(
    String path, {
    bool isAuthenticationRequired = false,
    Map<String, String> parameters,
  }) async {
    String token;
    if (isAuthenticationRequired) token = await getBearerToken();
    final header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-koodai-api': 'mobile',
      'Authorization': 'Bearer $token'
    };
    return await _client.get(
      Uri.https(_appConfig.baseUrl, path, parameters),
      headers: header,
    );
  }

  Future<Response> post(
    String path,
    String request, {
    bool isAuthenticationRequired = false,
  }) async {
    String token;
    if (isAuthenticationRequired) token = await getBearerToken();
    final header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-koodai-api': 'mobile',
      'Authorization': 'Bearer $token'
    };
    return await _client.post(
      Uri.https(_appConfig.baseUrl, path),
      headers: header,
      body: request,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    bool isAuthenticationRequired = false,
  }) async {
    String token;
    if (isAuthenticationRequired) token = await getBearerToken();
    final header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-koodai-api': 'mobile',
      'Authorization': 'Bearer $token'
    };
    return await _client.delete(
      Uri.https(_appConfig.baseUrl, path),
      headers: header,
    );
  }

  Future<Response> put(
    String path,
    String request, {
    bool isAuthenticationRequired = false,
  }) async {
    String token;
    if (isAuthenticationRequired) token = await getBearerToken();
    final header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-koodai-api': 'mobile',
      'Authorization': 'Bearer $token'
    };
    return await _client.put(
      Uri.https(_appConfig.baseUrl, path),
      headers: header,
      body: request,
    );
  }

  Future<String> getBearerToken() async {
    String loginResponseText =
        await _storageService.getEncryptedValue(Constants.loginResponse);
    return loginResponseFromJson(loginResponseText).token;
  }
}
