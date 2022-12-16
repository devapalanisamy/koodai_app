import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/change_password_request.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final INavigationService _navigationService;
  final IAuthenticationService _authenticationService;

  ChangePasswordViewModel(this._navigationService, this._authenticationService);

  Future<void> changePassword(String oldpassword, String newPassword) async {
    setState(ViewState.Busy);
    final isChanged = await _authenticationService.changePassword(
        ChangePasswordRequest(
            oldPassword: oldpassword, newPassword: newPassword));
    if (isChanged)
      _navigationService.pop(navigationFlow: NavigationFlow.Default);
    setState(ViewState.Idle);
  }
}
