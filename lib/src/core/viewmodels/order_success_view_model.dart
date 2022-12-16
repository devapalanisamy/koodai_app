import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class OrderSuccessViewModel extends BaseViewModel {
  final INavigationService _navigationService;

  OrderSuccessViewModel(this._navigationService);

  Future<void> returnToHome() async {
    await _navigationService.pushNamedAndRemoveUntil(
      RoutePaths.bottomTabBar,
      navigationFlow: NavigationFlow.Default,
    );
  }
}
