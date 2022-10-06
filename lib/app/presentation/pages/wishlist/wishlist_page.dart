import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injector/injector.dart';

import './wishlist_controller.dart';
import '../../../../domain/entitites/product.dart';
import '../../widgets/wishlist_item.dart';

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
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
                "lib/app/presentation/assets/images/logoonly.svg"),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text(
            "Your Wishlist",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ControlledWidgetBuilder<WishlistController>(
            builder: (BuildContext _, WishlistController controller) {
          final products = controller.wishlist.products;

          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ),
                )
              : controller.wishlist.wishlistItems.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.heart_broken,
                          size: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const Text(
                          "Your Wishlist is empty",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ))
                  : Column(children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.wishlist.wishlistItems.length,
                            itemBuilder: ((context, index) {
                              final wishlistItem =
                                  controller.wishlist.wishlistItems[index];
                              final selectedProduct = products!.firstWhere(
                                  (product) =>
                                      product.id ==
                                      controller.wishlist.wishlistItems[index]
                                          ['productId']);
                              return WishlistItem(
                                id: wishlistItem['id'],
                                productName:
                                    selectedProduct.productName.toString(),
                                productId: selectedProduct.id,
                                imageUrl: selectedProduct.imageUrl.toString(),
                                price:
                                    int.parse(selectedProduct.price.toString()),
                                action: () => controller
                                    .deleteWishlist(wishlistItem['id']),
                                route: () => controller
                                    .navigateToProductDetail(selectedProduct),
                              );
                            })),
                      ),
                    ]);
        }),
      );
}
