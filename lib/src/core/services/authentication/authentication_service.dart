import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/configs/constants.dart';
import 'package:ConsumerApp/src/core/models/change_password_request.dart';
import 'package:ConsumerApp/src/core/models/forgot_password_request.dart';
import 'package:ConsumerApp/src/core/models/login_request.dart';
import 'package:ConsumerApp/src/core/models/login_response.dart';
import 'package:ConsumerApp/src/core/models/new_user.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';
import 'package:ConsumerApp/src/core/models/user.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:ConsumerApp/src/core/services/storage/i_storage_service.dart';

class AuthenticationService extends IAuthenticationService {
  final IRestClient _restClient;
  final IStorageService _storageService;

  AuthenticationService(this._restClient, this._storageService);
  @override
  Future<bool> registerNewUser(NewUser newUser) async {
    final response = await _restClient.post(
      ApiPaths.registerNewUser,
      newUserToJson(newUser),
    );
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await _restClient.post(
      ApiPaths.login,
      loginRequestToJson(loginRequest),
    );
    if (response.success) {
      _storageService.setEncryptedValue(Constants.loginResponse, response.body);
      return loginResponseFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    final response = await _restClient.post(
      ApiPaths.login,
      forgotPasswordRequestToJson(forgotPasswordRequest),
    );
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> isLoggedIn() async {
    final loginResponseText =
        await _storageService.getEncryptedValue('loginResponse');
    if (loginResponseText == null) return false;
    final loginResponse = loginResponseFromJson(loginResponseText);
    if (loginResponse.token.isNotEmpty) return true;
    return false;
  }

  @override
  Future<String> getAccountId() async {
    String loginResponseText =
        await _storageService.getEncryptedValue(Constants.loginResponse);
    return loginResponseFromJson(loginResponseText).id;
  }

  @override
  Future<User> getCurrentUser() async {
    final path = ApiPaths.userAccount + '/' + 'current';
    final response = await _restClient.get(
      path,
      isAuthenticationRequired: true,
    );
    if (response.success) {
      return userFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> updateUser(User user) async {
    final response = await _restClient.put(
      ApiPaths.userAccount,
      userToJson(user),
      isAuthenticationRequired: true,
    );
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    final response = await _restClient.post(
      ApiPaths.changePassword,
      changePasswordRequestToJson(changePasswordRequest),
      isAuthenticationRequired: true,
    );
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }
}
