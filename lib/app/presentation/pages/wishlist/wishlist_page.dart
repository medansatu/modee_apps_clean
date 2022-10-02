import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import './wishlist_controller.dart';
import '../../../../domain/entitites/wishlist.dart';
import '../../../../domain/entitites/product.dart';

class WishlistPage extends View {
  WishlistPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    final wishlistController = Injector.appInstance.get<WishlistController>();
    return _WishlistViewState(wishlistController);
  }
}

class _WishlistViewState extends ViewState<WishlistPage, WishlistController> {
  _WishlistViewState(super.controller);

  @override
  // TODO: implement view
  Widget get view => Scaffold(
        appBar: AppBar(
          title: Text("Wishlist"),
        ),
        body: ControlledWidgetBuilder<WishlistController>(
          builder:(BuildContext _, WishlistController controller) {
            String? encodedProducts = controller.wishlist.products;
            final products = Product.decode(encodedProducts.toString());
            final selectedProduct = products.firstWhere((product) => product.id == controller.wishlist.wishlistItems[0]['productId']);

            return controller.isLoading 
          ? const Center(child: CupertinoActivityIndicator())
          : controller.wishlist.wishlistItems.isEmpty ? Center(child: Text("Wishlist is empty")) : Center(child: Text(selectedProduct.productName.toString()));
          }),
      );
}
