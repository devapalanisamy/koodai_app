import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:flutter/material.dart';

abstract class INavigationService {
  Map<NavigationFlow, GlobalKey<NavigatorState>> navigatorKeys;
  Future<T> pushNamed<T, S>(String routeName,
      {S arguments, @required NavigationFlow navigationFlow});
  Future<T> pushNamedAndRemoveUntil<T, S>(String routeName,
      {S arguments, NavigationFlow navigationFlow});
  void pop<T>({T arguments, @required NavigationFlow navigationFlow});
  void popUntil(String routeName,
      {dynamic arguments, @required NavigationFlow navigationFlow});
}
