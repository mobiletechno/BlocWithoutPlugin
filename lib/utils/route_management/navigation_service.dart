import 'package:flutter/material.dart';

class NavigationService {

  NavigationService._privateConstructor();
  static final NavigationService instance = NavigationService._privateConstructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  dynamic routeTo(String route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(route);
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }

}