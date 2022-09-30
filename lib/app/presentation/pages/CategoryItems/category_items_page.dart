import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import 'category_items_controller.dart';
import '../../../../domain/entitites/category.dart';
import '../../../../domain/entitites/product.dart';
import '../../widgets/product_item.dart';

class CategoryItemsPage extends View {
  static const routeName = "/category-items";

  final Map<String, dynamic> arguments;

  CategoryItemsPage(this.arguments, {Key? key}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    final categoryController = Injector.appInstance.get<CategoryItemsController>();
    return _CategoryViewState(categoryController);
  }
}

class _CategoryViewState extends ViewState<CategoryItemsPage, CategoryItemsController> {
  _CategoryViewState(super.controller);
  
  @override
  Widget get view {
    final category = widget.arguments['category'] as Category;
    final products = widget.arguments['products'] as List<Product>;
    final selectedProduct =
        products.where((prod) => prod.category['id'] == category.id).toList();
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color:Theme.of(context).accentColor),
        title: Text(category.category.toString(), style: TextStyle(color: Theme.of(context).accentColor),),
        // leading: Padding(
        //   padding: EdgeInsets.all(10),
        //   child: SvgPicture.asset("assets/images/logoonly.svg"),
        // ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_outlined,
              // color: Theme.of(context).accentColor,
              size: 30,
            ),
          )
        ],
      ),
      body: ControlledWidgetBuilder<CategoryItemsController>(
        builder: (BuildContext _, CategoryItemsController controller) => GridView.builder(
          itemCount: selectedProduct.length,
          itemBuilder: ((context, index) => ProductItem(
                id: selectedProduct[index].id,
                description: selectedProduct[index].description,
                price: selectedProduct[index].price,
                imageUrl: selectedProduct[index].imageUrl,
                productName: selectedProduct[index].productName,
                route: () => controller.navigateToProductDetail(selectedProduct[index]),
              )),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: MediaQuery.of(context).size.height * 0.33),            
        ),
      ),
    );
  }


}


