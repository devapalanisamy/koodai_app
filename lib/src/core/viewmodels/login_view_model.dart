import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/login_request.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class LoginViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final INavigationService _navigationService;

  LoginViewModel(this._authenticationService, this._navigationService);
  Future<void> login(String username, String password) async {
    try {
      final result = await _authenticationService
          .login(LoginRequest(userName: username, password: password));
      if (result.token.isNotEmpty)
        _navigationService.pushNamedAndRemoveUntil(RoutePaths.bottomTabBar,
            navigationFlow: NavigationFlow.Default);
    } catch (e) {
      print('something went wrong: $e');
    }
  }

  Future<void> register() async {
    await _navigationService.pushNamed(RoutePaths.register,
        navigationFlow: NavigationFlow.Default);
  }

  Future<void> forgotPassword() async {
    await _navigationService.pushNamed(RoutePaths.forgotPassword,
        navigationFlow: NavigationFlow.Default);
  }

  Future<void> showProducts() async {
    await _navigationService.pushNamedAndRemoveUntil(RoutePaths.bottomTabBar,
        navigationFlow: NavigationFlow.Default);
  }
}
