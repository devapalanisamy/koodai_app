import 'package:ConsumerApp/src/core/models/change_password_request.dart';
import 'package:ConsumerApp/src/core/models/forgot_password_request.dart';
import 'package:ConsumerApp/src/core/models/login_request.dart';
import 'package:ConsumerApp/src/core/models/login_response.dart';
import 'package:ConsumerApp/src/core/models/new_user.dart';
import 'package:ConsumerApp/src/core/models/user.dart';

abstract class IAuthenticationService {
  Future<bool> registerNewUser(NewUser newUser);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<bool> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<bool> isLoggedIn();
  Future<String> getAccountId();
  Future<User> getCurrentUser();
  Future<bool> updateUser(User user);
  Future<bool> changePassword(ChangePasswordRequest changePasswordRequest);
}
