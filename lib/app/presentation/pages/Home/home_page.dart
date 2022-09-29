import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:injector/injector.dart';

import './home_controller.dart';
import '../../../../domain/entitites/product.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key : key);
  
  @override
  State<StatefulWidget> createState() {
    final homeController = Injector.appInstance.get<HomeController>();
    return _HomeViewState(homeController);
  }
}

class _HomeViewState extends ViewState<HomePage, HomeController> {
  _HomeViewState(super.controller);
  
  @override
  // TODO: implement view
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(title: const Text("Home"),),
    body: ControlledWidgetBuilder<HomeController>(builder: (BuildContext _, HomeController controller) => 
    controller.isLoading
    ? const Center(child: CupertinoActivityIndicator(),)
    : ListView.builder(
      itemCount: controller.categories.length,
      itemBuilder: (BuildContext _, int index) {
        final product = controller.categories[index];
        return Center(child: Image.network(product.imageUrl.toString()));
      },)),
  );
}