import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/user.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  User user;
  final IAuthenticationService _authenticationService;
  final INavigationService _navigationService;

  ProfileViewModel(
    this._authenticationService,
    this._navigationService,
  );
  Future<void> setUser() async {
    setState(ViewState.Busy);
    user = await _authenticationService.getCurrentUser();
    setState(ViewState.Idle);
  }

  Future<void> updateUser() async {
    setState(ViewState.Busy);
    final isUpdated = await _authenticationService.updateUser(user);
    if (isUpdated)
      _navigationService.pop(navigationFlow: NavigationFlow.Default);
    setState(ViewState.Idle);
  }
}
