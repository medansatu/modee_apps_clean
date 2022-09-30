import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './home_presenter.dart';
import '../../../../domain/entitites/product.dart';
import '../../../../domain/entitites/category.dart';
import '../CategoryItems/category_items_page.dart';
import '../../pages/ProductDetail/product_detail_page.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  @override
  void initListeners() {
    _initObserver();
    _getCategories();
    _getProducts();
  }

  void _getProducts() {
    _showLoading();
    _presenter.getProducts();
  }

  //Category
  void _getCategories() {
    _showLoading();
    _presenter.getCategories();
  }

  void _initObserver() {
    _presenter.onErrorGetProducts = (e) {};
    _presenter.onErrorGetCategories = (e) {};
    _presenter.onFinishGetProducts =() {
      _hideLoading();
    };
    _presenter.onFinishGetCategories = () {
      // _hideLoading();
    };      
    _presenter.onSuccessGetProducts = (List<Product> data) {
      _products = data;
    };
    _presenter.onSuccessGetCategories = (List<Category> data) {
      _categories = data;
    };  
    // _presenter.stopLoading = (){
    //   if(_getCategoriesFinish && _getProductsFinish) {
    //   _hideLoading();
    // }
    // };    
  }

  void navigateToCategoryItems(List<Product> product, Category category) {
    final context = getContext();
    Navigator.pushNamed(context, CategoryItemsPage.routeName, arguments: {'category' : category, 'products' : product});
  }

  void navigateToProductDetail(Product arguments) {
    final context = getContext();
    Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: arguments);
  }

  void _showLoading() {
    _isLoading = true;
    refreshUI();
  }

  void _hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @override
  void onDisposed() {
    super.onDisposed();
    _presenter.dispose();
  }
}
