import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './cart_presenter.dart';
import '../../../../domain/entitites/cart.dart';
import '../../../../domain/entitites/general_response.dart';

class CartController extends Controller {
  final CartPresenter _presenter;

  CartController(this._presenter);

  GeneralResponse? _cartItem;
  GeneralResponse? get cartItem => _cartItem;

  GeneralResponse? _updateResponse;
  GeneralResponse? get updateResponse => _updateResponse;

  bool _isLoading = false;
  bool get isLoading => _isLoading;  

  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;

  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;

  Cart _cart = Cart(id: 0, cartItems: []);
  Cart get cart => _cart;

  // int itemTotal = 0;
  int _grandTotal = 0;
  int get grandTotal => _grandTotal;

  // int sumTotal() {       
  //     _grandTotal += itemTotal;
  //     // refreshUI();   
  //     return _grandTotal;
             
  // }

  // int total() {
  //   refreshUI();
  //   return _grandTotal;
  // }
  
  @override
  void initListeners() {
    _initObserver();
    _getCart();
    _getTotal();
  }

  void _getTotal() {
    _presenter.getCartTotal();
  }

  void _getCart() {
    _showLoading();
    _presenter.getCart();
  }

  Future<void> deleteCart(int cartItemId) async {    
    _presenter.deleteCart(cartItemId); 
    do {
      await Future.delayed(const Duration(milliseconds: 1));
    } while (!_isDeleted);    
    if(_cartItem?.success == true)  {
      _presenter.getCart();
      _isDeleted = false;
      _getTotal();
      refreshUI();
    }    
  }

  Future<void> updateCart(int cartItemId, int quantity) async {    
    _presenter.updateCart(cartItemId, quantity); 
    do {
      await Future.delayed(const Duration(milliseconds: 1));
    } while (!_isUpdated);    
    if(_updateResponse?.success == true)  {
      _presenter.getCart();
      _isUpdated = false;
      _getTotal();
      refreshUI();
    }    
  }

  void _initObserver() {
    _presenter.onErrorGetCart = (e) {};
    _presenter.onErrorDeleteFromCart = (e){};
    _presenter.onErrorUpdateCart = (e){};
    _presenter.onErrorGetCartTotal = (e) {};
    _presenter.onFinishGetCart = () {
      _hideLoading();
    };
    _presenter.onFinishDeleteFromCart = (){
      _successDelete();
    };
    _presenter.onFinishUpdateCart = (){
      _successUpdate();
    };
    _presenter.onFinishGetCartTotal = (){};
    _presenter.onSuccessGetCart = (Cart data) {
      _cart = data;
    };
    _presenter.onSuccessDeleteFromCart = (GeneralResponse? data) {
      _cartItem = data;
      //  _successDelete();
    };
    _presenter.onSuccessUpdateCart = (GeneralResponse? data){
      _updateResponse = data;
    };
    _presenter.onSuccessGetCartTotal = (int data) {
      _grandTotal = data;
    };
  }

  void _successDelete() {
    _isDeleted = true;    
  }

  void _successUpdate() {
    _isUpdated = true;
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