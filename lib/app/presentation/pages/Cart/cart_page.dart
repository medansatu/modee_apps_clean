import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import './cart_controller.dart';
import '../../../../domain/entitites/cart.dart';

class CartPage extends View {
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
  // TODO: implement view
  Widget get view => Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: ControlledWidgetBuilder<CartController>(
          builder:(BuildContext _, CartController controller) => 
          controller.isLoading 
          ? const Center(child: CupertinoActivityIndicator())
          : Center(child: Text(controller.cart.id.toString()))),
      );
}
