import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:flutter/material.dart';

class NavigationService implements INavigationService {
  @override
  Future<T> pushNamed<T, S>(String routeName,
      {S arguments, NavigationFlow navigationFlow}) {
    final navigatorKey = _getNavigatorKey(navigationFlow: navigationFlow);
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<T> pushNamedAndRemoveUntil<T, S>(String routeName,
      {S arguments, NavigationFlow navigationFlow}) {
    final navigatorKey = _getNavigatorKey(navigationFlow: navigationFlow);
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  @override
  void pop<T>({T arguments, NavigationFlow navigationFlow}) {
    final navigatorKey = _getNavigatorKey(navigationFlow: navigationFlow);
    return navigatorKey.currentState.pop(arguments);
  }

  @override
  Map<NavigationFlow, GlobalKey<NavigatorState>> navigatorKeys = {
    NavigationFlow.Default: GlobalKey<NavigatorState>(),
    NavigationFlow.Home: GlobalKey<NavigatorState>(),
    NavigationFlow.Menu: GlobalKey<NavigatorState>(),
    NavigationFlow.Basket: GlobalKey<NavigatorState>(),
    NavigationFlow.More: GlobalKey<NavigatorState>(),
  };

  GlobalKey<NavigatorState> _getNavigatorKey({NavigationFlow navigationFlow}) {
    if (navigationFlow == null) return navigatorKeys[NavigationFlow.Default];
    return navigatorKeys[navigationFlow];
  }

  @override
  void popUntil(String routeName, {arguments, navigationFlow}) {
    final navigatorKey = _getNavigatorKey(navigationFlow: navigationFlow);
    navigatorKey.currentState.popUntil((r) => r.isFirst);
  }
}
