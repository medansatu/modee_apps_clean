import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import './wishlist_controller.dart';
import '../../../../domain/entitites/wishlist.dart';

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
          builder:(BuildContext _, WishlistController controller) => 
          controller.isLoading 
          ? const Center(child: CupertinoActivityIndicator())
          : Center(child: Text(controller.wishlist.id.toString()))),
      );
}
