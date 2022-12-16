import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/menu.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/products/i_products_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';
import 'package:tuple/tuple.dart';

class MenuViewModel extends BaseViewModel {
  final IProductsService _productsService;
  final INavigationService _navigationService;

  MenuViewModel(this._productsService, this._navigationService);

  List<Menu> menus;

  Future<void> setMenus() async {
    setState(ViewState.Busy);
    menus = await _productsService.getMenu();
    setState(ViewState.Idle);
  }

  Future<void> showMenu(Menu menu) async {
    if (menu.isCategory) {
      await _navigationService.pushNamed(RoutePaths.productsList,
          navigationFlow: NavigationFlow.Menu,
          arguments: Tuple2(menu.name, menu.products));
    } else {
      await _navigationService.pushNamed(RoutePaths.menu,
          navigationFlow: NavigationFlow.Menu,
          arguments: Tuple2(menu.name, menu.subMenus));
    }
  }
}
