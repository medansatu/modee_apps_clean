import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entitites/product.dart';
import './cart_controller.dart';
import '../../../../domain/entitites/cart.dart';

class CartPage extends View {
  // final List<Product> products;
  
  CartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    final cartController = Injector.appInstance.get<CartController>();
    return _CartViewState(cartController);
  }
}

class _CartViewState extends ViewState<CartPage, CartController> {
  _CartViewState(super.controller);

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: ControlledWidgetBuilder<CartController>(
          builder:(BuildContext _, CartController controller) {
            String? encodedProducts = controller.cart.products;
            final products = Product.decode(encodedProducts.toString());
            final selectedProduct = products.firstWhere((product) => product.id == controller.cart.cartItems[0]['productId']);
                        
            return controller.isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : controller.cart.cartItems.isEmpty ? Center(child: Text("Cart is empty")) : Center(child: Text(selectedProduct.productName.toString()));
          }),
      );
}
