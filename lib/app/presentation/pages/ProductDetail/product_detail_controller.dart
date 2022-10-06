import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './product_detail_presenter.dart';

class ProductDetailController extends Controller{
  final ProductDetailPresenter _presenter;

  ProductDetailController(this._presenter);

  int? _cartItemId;
  int? get cartItemId => _cartItemId;

  int? _wishlistItemId;
  int? get wishlistItemId => _wishlistItemId;

  @override
  void initListeners() {    
    _initObserver();
  }

  void addtoCart(int productId) {
    _presenter.addToCart(productId);
    final context = getContext();
    Fluttertoast.showToast(msg: "Item added to Cart!", toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor,);
  }

  void addToWishlist(int productId) {
    final context = getContext();
    _presenter.addToWishlist(productId);
    Fluttertoast.showToast(msg: "Item added to Wishlist!", toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor,);
  }


  void _initObserver() {
    _presenter.onErrorAddtoCart = (e) {
      
    };
    _presenter.onErrorAddtoWishlist = (e) {};
    _presenter.onFinishAddtoCart = () {
      
    };
    _presenter.onFinishAddtoWishlist =() {};
    _presenter.onSuccessAddToCart = (int? data) {
      _cartItemId = data;
    };
    _presenter.onSuccessAddToWishlist = (int? data) {
      _wishlistItemId = data;
    };
  }

  @override
  void dispose() {
    super.dispose();    
    _presenter.dispose();
  }

}