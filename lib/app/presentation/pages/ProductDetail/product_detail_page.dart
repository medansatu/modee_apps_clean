import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import '../../../../domain/entitites/product.dart';
import '../../widgets/procut_detail.dart';
import './product_detail_controller.dart';
import '../Tabs/tabs_page.dart';

class ProductDetailPage extends View {
  static const routeName = '/product-detail';

  final Product arguments;

  ProductDetailPage(this.arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    final productDetailController =
        Injector.appInstance.get<ProductDetailController>();
    return _ProductDetailViewState(productDetailController);
  }
}

class _ProductDetailViewState
    extends ViewState<ProductDetailPage, ProductDetailController> {
  _ProductDetailViewState(super.controller);

  @override
  Widget get view {
    final product = widget.arguments;

    Widget _buildBottomButton(Color backgroundColor, String text,
        Color fontColor, VoidCallback action) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.42,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).accentColor, width: 2)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => action(),
            splashColor: Colors.pink,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "Product Detail",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TabsPage(1)));
            },
            icon: Icon(
              Icons.shopping_bag,
              size: 30,
            ),
          )
        ],
      ),
      body: ProductDetail(
        price: product.price,
        imageUrl: product.imageUrl,
        productName: product.productName,
        description: product.description,
      ),
      bottomNavigationBar: ControlledWidgetBuilder<ProductDetailController>(
        builder: (BuildContext context, ProductDetailController controller) =>
            Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomButton(Colors.transparent, "Add to Wishlist",
                  Theme.of(context).accentColor, () => controller.addToWishlist(product.id)),
              _buildBottomButton(Theme.of(context).accentColor, "Add to Cart",
                  Theme.of(context).primaryColor, () => controller.addtoCart(product.id)),
            ],
          ),
        ),
      ),
    );
  }
}
