import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/bottom_tab_bar_view_model.dart';
import 'package:ConsumerApp/src/service_locator.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';
import 'package:ConsumerApp/src/ui/router.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:ConsumerApp/src/ui/views/basket_view.dart';
import 'package:ConsumerApp/src/ui/views/home_view.dart';
import 'package:ConsumerApp/src/ui/views/menu_view.dart';
import 'package:ConsumerApp/src/ui/views/login_view.dart';
import 'package:ConsumerApp/src/ui/views/more_view.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;

class BottomTabBarView extends StatefulWidget {
  @override
  _BottomTabBarViewState createState() => _BottomTabBarViewState();
}

class _BottomTabBarViewState extends State<BottomTabBarView> {
  final _controller = CupertinoTabController();
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomTabBarViewModel>(
      setupViewModel: (viewmodel) async => null,
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async => handleHardwareBackButton(),
        child: StreamBuilder<Basket>(
            stream: viewModel.basketStream,
            builder: (context, snapshot) {
              String total;
              if (snapshot.hasData)
                total = snapshot.data.total().toStringAsFixed(2);
              else
                total = viewModel.total.toStringAsFixed(2);
              return CupertinoTabScaffold(
                  controller: _controller,
                  tabBar: CupertinoTabBar(
                    items: buildTabBarItems(context, total),
                    inactiveColor:
                        Theme.of(context).colorScheme.secondaryVariant,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    onTap: (index) => _onTapped(index),
                  ),
                  tabBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _getTabView(HomeView(), NavigationFlow.Home);
                      case 1:
                        return _getTabView(MenuView(), NavigationFlow.Menu);
                      case 2:
                        return _getTabView(BasketView(), NavigationFlow.Basket);
                      case 3:
                        return _getTabView(MoreView(), NavigationFlow.More);
                      default:
                        return _getTabView(LoginView(), NavigationFlow.Home);
                    }
                  });
            }),
      ),
    );
  }

  Future<bool> handleHardwareBackButton() async {
    {
      final canPop = !await getCurrentNavigatorKey().currentState.maybePop();
      if (canPop && _controller.index != 0) {
        setState(() {
          _controller.index = 0;
        });
        return false;
      }
      return canPop;
    }
  }

  List<BottomNavigationBarItem> buildTabBarItems(
    BuildContext context,
    String total,
  ) {
    return [
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Icon(Icons.home_outlined),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Icon(Icons.menu_outlined),
        ),
        label: 'Menu',
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Stack(children: [
            Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_basket_outlined,
                )),
          ]),
        ),
        label: total == '0.00' ? 'Basket' : '£' + total,
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Icon(Icons.more_horiz),
        ),
        label: 'More',
      ),
    ];
  }

  Widget _getTabView(Widget widget, NavigationFlow flow) {
    return CupertinoTabView(
      onGenerateRoute: Router.generateRoute,
      builder: (context) => widget,
      navigatorKey: serviceLocator<INavigationService>().navigatorKeys[flow],
    );
  }

  _onTapped(int index) {
    switch (index) {
      case 0:
        if (index == _currentIndex) {
          serviceLocator<INavigationService>()
              .popUntil(RoutePaths.menu, navigationFlow: NavigationFlow.Home);
        } else {
          _setCurrentTabIndex(index);
        }
        break;
      case 1:
        if (index == _currentIndex) {
          serviceLocator<INavigationService>()
              .popUntil(RoutePaths.menu, navigationFlow: NavigationFlow.Menu);
        } else {
          _setCurrentTabIndex(index);
        }
        break;
      case 2:
        if (index == _currentIndex) {
          serviceLocator<INavigationService>().popUntil(RoutePaths.basket,
              navigationFlow: NavigationFlow.Basket);
        } else {
          _setCurrentTabIndex(index);
        }
        break;
      case 3:
        if (index == _currentIndex) {
          serviceLocator<INavigationService>().popUntil(RoutePaths.profile,
              navigationFlow: NavigationFlow.More);
        } else {
          _setCurrentTabIndex(index);
        }
        break;
    }
  }

  _setCurrentTabIndex(int index) {
    setState(() {
      _currentIndex = index;
      _controller.index = index;
    });
  }

  GlobalKey<NavigatorState> getCurrentNavigatorKey() {
    switch (_controller.index) {
      case 0:
        return serviceLocator<INavigationService>()
            .navigatorKeys[NavigationFlow.Home];
        break;
      case 1:
        return serviceLocator<INavigationService>()
            .navigatorKeys[NavigationFlow.Menu];
        break;
      case 1:
        return serviceLocator<INavigationService>()
            .navigatorKeys[NavigationFlow.Basket];
        break;
      case 2:
        return serviceLocator<INavigationService>()
            .navigatorKeys[NavigationFlow.More];
        break;
    }

    return null;
  }
}
