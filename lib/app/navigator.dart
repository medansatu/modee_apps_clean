import 'package:flutter/material.dart';

import './presentation/pages/Register/register_page.dart';
import './presentation/pages/login/login_page.dart';

class AppNavigator {
  Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RegisterPage.routeName: 
      return MaterialPageRoute(builder: (BuildContext _) => RegisterPage());

      case LoginPage.routeName:
      return MaterialPageRoute(builder: (BuildContext _) => LoginPage());
    }
  }
}