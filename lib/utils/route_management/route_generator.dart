

import 'package:blocwithoutplugin/presentation/cart/ui/cart.dart';
import 'package:flutter/material.dart';


import 'package:blocwithoutplugin/presentation/homescreen/ui/home.dart';


class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => MyHomePage(),
        );
      case '/cart':
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