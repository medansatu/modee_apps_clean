import 'package:flutter/material.dart';

import './presentation/pages/Register/register_page.dart';
import './presentation/pages/login/login_page.dart';
import './presentation/pages/CategoryItems/category_items_page.dart';
import './presentation/pages/ProductDetail/product_detail_page.dart';
import './presentation/pages/Tabs/tabs_page.dart';
import '../domain/entitites/product.dart';

class AppNavigator {
  Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RegisterPage.routeName: 
      return MaterialPageRoute(builder: (BuildContext _) => RegisterPage());

      case LoginPage.routeName:
      return MaterialPageRoute(builder: (BuildContext _) => LoginPage());

      case CategoryItemsPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (BuildContext _) => CategoryItemsPage(arguments));

      case ProductDetailPage.routeName:
      final arguments = settings.arguments as Product;
      return MaterialPageRoute(builder: (BuildContext _) => ProductDetailPage(arguments));

      case TabsPage.routeName:
      return MaterialPageRoute(builder: (BuildContext _) => TabsPage(0));
    }
  }
}