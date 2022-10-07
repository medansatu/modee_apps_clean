import 'package:flutter/material.dart';

import 'package:injector/injector.dart';

import './app/di/app_module.dart';
import './app/presentation/pages/login/login_page.dart';
import './app/presentation/pages/Register/register_page.dart';
import './app/presentation/pages/Home/home_page.dart';
import './app/presentation/pages/Cart/cart_page.dart';
import './app/presentation/pages/wishlist/wishlist_page.dart';
import './app/presentation/pages/Tabs/tabs_page.dart';
import './app/navigator.dart';


void main() {
  AppModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appNavigator = Injector.appInstance.get<AppNavigator>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.pink,
        primaryColor: Colors.black,
        accentColor: const Color.fromRGBO(255, 130, 201, 1),
      ),
      home: LoginPage(),
      onGenerateRoute: appNavigator.onGenerateRoutes,
    );
  }
}