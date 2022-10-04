import 'package:final_project_clean/domain/entitites/delete_response.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './cart_presenter.dart';
import '../../../../domain/entitites/cart.dart';

class CartController extends Controller {
  final CartPresenter _presenter;

  CartController(this._presenter);

  DeleteResponse? _cartItem;
  DeleteResponse? get cartItem => _cartItem;

  bool _isLoading = false;
  bool get isLoading => _isLoading;  

  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;

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

  Future<void> deleteCart(int cartItemId) async {    
    _presenter.deleteCart(cartItemId); 
    do {
      await Future.delayed(const Duration(milliseconds: 100));
    } while (!_isDeleted);    
    if(cartItem?.success == true)  {
      _presenter.getCart();
      // refreshUI();
    }    
  }

  void _initObserver() {
    _presenter.onErrorGetCart = (e) {};
    _presenter.onErrorDeleteFromCart = (e){};
    _presenter.onFinishGetCart = () {
      _hideLoading();
    };
    _presenter.onFinishDeleteFromCart = (){
      _successDelete();
    };
    _presenter.onSuccessGetCart = (Cart data) {
      _cart = data;
    };
    _presenter.onSuccessDeleteFromCart = (DeleteResponse? data) {
      _cartItem = data;
      //  _successDelete();
    };
  }

  void _successDelete() {
    _isDeleted = true;
    // refreshUI();
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