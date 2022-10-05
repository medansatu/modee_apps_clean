import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entitites/product.dart';
import './cart_controller.dart';
import '../../../../domain/entitites/cart.dart';
import '../../widgets/cart_items.dart';

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
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
                "lib/app/presentation/assets/images/logoonly.svg"),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text(
            "Your Cart",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ControlledWidgetBuilder<CartController>(
            builder: (BuildContext _, CartController controller) {
          final products = controller.cart.products;
          // final products = Product.decode(encodedProducts.toString());

          return controller.isLoading
              ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  )
              : controller.cart.cartItems.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const Text(
                          "Your Cart is empty",
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
                            itemCount: controller.cart.cartItems.length,
                            itemBuilder: ((context, index) {
                              final cartItem = controller.cart.cartItems[index];
                              final selectedProduct = products!.firstWhere(
                                  (product) => product.id == controller.cart.cartItems[index]['productId']);
                              // controller.itemTotal = int.parse(selectedProduct.price.toString()) * int.parse(cartItem['quantity'].toString());
                              // controller.sumTotal();
                              print(controller.grandTotal);                              
                              return CartItem(
                                  id: cartItem['id'],
                                  productName:
                                      selectedProduct.productName.toString(),
                                  price: int.parse(
                                      selectedProduct.price.toString()),
                                  quantity: int.parse(
                                      cartItem['quantity'].toString()),
                                  productId: selectedProduct.id,
                                  imageUrl:
                                      selectedProduct.imageUrl.toString(),
                                      action: () => controller.deleteCart(cartItem['id']),
                                      addQty: () => controller.updateCart(cartItem['id'], ((cartItem['quantity'] as int) + 1)),
                                      deductQty: () => controller.updateCart(cartItem['id'], ((cartItem['quantity'] as int) - 1)),);
                            })),
                      ),
                      // Container(
                      //   child: Row(children: [
                      //     Text("Total"),
                      //     Text(controller.total().toString())                          
                      //   ]),
                      // )
                    ]);
        }),
      );
}
