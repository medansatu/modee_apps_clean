import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/product_item.dart';
import './home_controller.dart';
import '../../../../domain/entitites/product.dart';
import '../../widgets/new_arrival_item.dart';
import '../../widgets/category_item.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    final homeController = Injector.appInstance.get<HomeController>();
    return _HomeViewState(homeController);
  }
}

class _HomeViewState extends ViewState<HomePage, HomeController> {
  _HomeViewState(super.controller);

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget get view => ControlledWidgetBuilder<HomeController>(
          builder: (BuildContext _, HomeController controller) {
            final List<Product> products = controller.products;
            // var productCopy = [...productsdata];
            print("PRODUCT DATA: $products");
            // print("PRODUCT COPY: $productCopy");
            return Scaffold(
                  key: globalKey,
                  appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
                "lib/app/presentation/assets/images/logoonly.svg"),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                final results = showSearch(context: context, delegate: ProductSearch(products));
              },
              icon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).accentColor,
                size: 30,
              ),
            )
          ],
                  ),
                  body: 
                                   
           controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("New Arrivals!"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 2 / 3),
                          padding: EdgeInsets.all(15),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            final prod_reversed =
                                controller.products.reversed.toList()[index];
                            return NewArrivalItem(
                              id: prod_reversed.id,
                              imageUrl: prod_reversed.imageUrl,
                              price: prod_reversed.price,
                              route: () => controller
                                  .navigateToProductDetail(prod_reversed),
                            );
                          }),
                        ),
                      ),
                      _buildSectionTitle("Categories"),
                      Expanded(
                        child: GridView.builder(
                          itemCount: controller.categories.length,
                          itemBuilder: ((context, index) {
                            final category = controller.categories[index];
                            return CategoryItem(
                              id: category.id,
                              categoryName: category.category,
                              imageUrl: category.imageUrl,
                              route: () => controller.navigateToCategoryItems(
                                  products, category),
                            );
                          }),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        ),
                      ),
                    ],
                  )
          
                  
                );
          },
      );
}

class ProductSearch extends SearchDelegate<List<Product>?> {
  final List<Product> products;
  
  final recentSearch = [
    "Flannel",
    "Dress",
  ];

   

  ProductSearch(this.products);

  List<Product>? foundProduct;
  
  @override
  List<Widget>? buildActions(BuildContext context) {    
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty) {
          close(context, null);
        } else {
        query = '';}
      },
    );
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return GridView.builder(
          itemCount: foundProduct!.length,
          itemBuilder: ((context, index) => ProductItem(
                id: foundProduct![index].id,
                description: foundProduct![index].description,
                price: foundProduct![index].price,
                imageUrl: foundProduct![index].imageUrl,
                productName: foundProduct![index].productName,
                route: () {},
              )),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: MediaQuery.of(context).size.height * 0.33),            
        );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    var searchProduct =  products.where((product) {
      
      final productLower = product.productName!.toLowerCase();
      final queryLower = query.toLowerCase();
      return productLower.contains(queryLower);
    }).toList();    

    foundProduct = searchProduct;

    var searchProductName = [];

    for(int i = 0; i<searchProduct.length; i++) {
      searchProductName.add(searchProduct[i].productName.toString());
    }

    final suggestions = query.isEmpty ? [] : searchProductName;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext _, int index) => ListTile(onTap: () {
        query = suggestions[index];
        showResults(context);
      },
        title: Text(suggestions[index].toString()),),
    );
  }
}
