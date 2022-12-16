import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/forgot_password_request.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final INavigationService _navigationService;

  ForgotPasswordViewModel(this._authenticationService, this._navigationService);
  Future<void> forgotPassword(String username) async {
    try {
      final result = await _authenticationService
          .forgotPassword(ForgotPasswordRequest(userName: username));
      if (result)
        _navigationService.pop(navigationFlow: NavigationFlow.Default);
    } catch (e) {
      print('something went wrong: $e');
    }
  }
}
