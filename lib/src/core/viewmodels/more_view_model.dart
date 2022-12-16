import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/storage/i_storage_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class MoreViewModel extends BaseViewModel {
  final INavigationService _navigationService;
  final IStorageService _storageService;
  final IAuthenticationService _authenticationService;

  bool isLoggedIn = false;

  MoreViewModel(this._navigationService, this._storageService,
      this._authenticationService);

  Future<void> showAddress() async {
    await _navigationService.pushNamed(RoutePaths.addressesList,
        navigationFlow: NavigationFlow.More);
  }

  Future<void> logout() async {
    final isStorageCleared = await _storageService.clear();
    if (isStorageCleared)
      await _navigationService.pushNamedAndRemoveUntil(RoutePaths.login,
          navigationFlow: NavigationFlow.Default);
  }

  Future<void> showProfile() async {
    await _navigationService.pushNamed(RoutePaths.profile,
        navigationFlow: NavigationFlow.Default);
  }

  Future<void> changePassword() async {
    await _navigationService.pushNamed(RoutePaths.changePassword,
        navigationFlow: NavigationFlow.Default);
  }

  Future<void> setLoginStatus() async {
    setState(ViewState.Busy);
    isLoggedIn = await _authenticationService.isLoggedIn();
    setState(ViewState.Idle);
  }
}
