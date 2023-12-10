

import 'package:blocwithoutplugin/config/constant.dart';
import 'package:blocwithoutplugin/presentation/cart_screen/ui/cart.dart';
import 'package:flutter/material.dart';


import 'package:blocwithoutplugin/presentation/home_screen/ui/home.dart';


class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    switch(settings.name) {
      case '${Constant.ROOT_NAME}':
        return MaterialPageRoute(builder: (context) => MyHomePage(),
        );
      case '${Constant.CART_NAME}':
        return MaterialPageRoute(builder: (context) =>
         MyCartPage(),
        );

      default:
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Center(
            child: Text("Not found ${settings.name}"),
          ),
        ));
    }
  }
}