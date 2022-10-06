import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/product.dart';
import '../../pages/ProductDetail/product_detail_page.dart';

class CategoryItemsController extends Controller {
  @override
  void initListeners() {
  }

  void navigateToProductDetail(Product arguments) {
    final context = getContext();
    Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: arguments);
  }
}