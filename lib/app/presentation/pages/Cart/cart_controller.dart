import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './cart_presenter.dart';
import '../../../../domain/entitites/cart.dart';

class CartController extends Controller {
  final CartPresenter _presenter;

  CartController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Cart _cart = Cart(id: 0, cartItems: []);
  Cart get cart => _cart;
  
  @override
  void initListeners() {
    _initObserver();
    _getCart();
  }

  void _getCart() {
    _showLoading();
    _presenter.getCart();
  }

  void _initObserver() {
    _presenter.onErrorGetCart = (e) {};
    _presenter.onFinishGetCart = () {
      _hideLoading();
    };
    _presenter.onSuccessGetCart = (Cart data) {
      _cart = data;
    };
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
  void dispose() {    
    super.dispose();
    _presenter.dispose();
  }
}