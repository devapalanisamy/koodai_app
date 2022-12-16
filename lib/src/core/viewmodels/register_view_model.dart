import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/new_user.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class RegisterViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final INavigationService _navigationService;

  RegisterViewModel(this._authenticationService, this._navigationService);
  Future<void> register(String firstName, String lastName, String email,
      String phone, String password) async {
    try {
      final result = await _authenticationService.registerNewUser(NewUser(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone));
      if (result)
        _navigationService.pushNamedAndRemoveUntil(RoutePaths.login,
            navigationFlow: NavigationFlow.Default);
    } catch (e) {
      print('something went wrong: $e');
    }
  }
}
