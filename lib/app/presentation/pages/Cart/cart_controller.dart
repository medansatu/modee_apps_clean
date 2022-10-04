import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './cart_presenter.dart';
import '../../../../domain/entitites/cart.dart';

class CartController extends Controller {
  final CartPresenter _presenter;

  CartController(this._presenter);

  int? _cartItemId;
  int? get cartItemId => _cartItemId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // bool _isDeleted = false;
  // bool get isDeleted => _isDeleted;

  Cart _cart = Cart(id: 0, cartItems: []);
  Cart get cart => _cart;

  int itemTotal = 0;
  // int get itemTotal => _itemTotal;
  int _grandTotal = 0;
  int get grandTotal => _grandTotal;

  int sumTotal() {       
      _grandTotal += itemTotal; 
      return _grandTotal;         
  }

  int total() {
    refreshUI();
    return _grandTotal;
  }
  
  @override
  void initListeners() {
    _initObserver();
    _getCart();
  }

  void _getCart() {
    _showLoading();
    _presenter.getCart();
  }

  void deleteCart(int cartItemId) {
    _presenter.deleteCart(cartItemId);         
  }

  void _initObserver() {
    _presenter.onErrorGetCart = (e) {};
    _presenter.onErrorDeleteFromCart = (e){};
    _presenter.onFinishGetCart = () {
      _hideLoading();
    };
    _presenter.onFinishDeleteFromCart = (){
      // _successDelete();
    };
    _presenter.onSuccessGetCart = (Cart data) {
      _cart = data;
    };
    _presenter.onSuccessDeleteFromCart = (int? data) {
      _cartItemId = data;
      //  _successDelete();
    };
  }

  // void _successDelete() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   _isDeleted = true;
  //   refreshUI();
  // }

  void _showLoading() {
    _isLoading = true;
    // refreshUI();
  }

  void _hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @override
  void dispose() {    
    super.dispose();
    _presenter.dispose();
  }
}