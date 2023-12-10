import 'package:blocwithoutplugin/presentation/home_screen/ui/home.dart';
import 'package:blocwithoutplugin/utils/route_management/navigation_service.dart';
import 'package:blocwithoutplugin/utils/route_management/route_generator.dart';
import 'package:flutter/material.dart';

import 'config/constant.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoutes,
      initialRoute: '${Constant.ROOT_NAME}',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            color: Colors.blueAccent,
            centerTitle: true,
            elevation: 10,
            actionsIconTheme: IconThemeData(color: Colors.white),
            foregroundColor: Colors.white),
        backgroundColor: Colors.white,
        errorColor: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Bloc without plugin',
      home: MyHomePage(),
    );
  }
}
