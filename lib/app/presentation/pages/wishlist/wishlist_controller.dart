import 'package:final_project_clean/domain/entitites/general_response.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/product.dart';
import '../ProductDetail/product_detail_page.dart';
import './wishlist_presenter.dart';
import '../../../../domain/entitites/wishlist.dart';

class WishlistController extends Controller {
  final WishlistPresenter _presenter;

  WishlistController(this._presenter);

  GeneralResponse? _wishlistItem;
  GeneralResponse? get wishlistItem => _wishlistItem;

  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Wishlist _wishlist = Wishlist(id: 0, wishlistItems: []);
  Wishlist get wishlist => _wishlist;
  
  @override
  void initListeners() {
    _initObserver();
    _getWishlist();
  }

  void _getWishlist() {
    _showLoading();
    _presenter.getWishlist();
  }

  Future<void> deleteWishlist(int wishlistItemId) async {    
    _presenter.deleteWishlist(wishlistItemId); 
    do {
      await Future.delayed(const Duration(milliseconds: 100));
    } while (!_isDeleted);    
    if(_wishlistItem?.success == true)  {
      _presenter.getWishlist();
      _isDeleted = false;
    }    
  }

  void navigateToProductDetail(Product arguments) {
    final context = getContext();
    Navigator.pushNamed(context, ProductDetailPage.routeName, arguments: arguments);
  }

  void _initObserver() {
    _presenter.onErrorGetWishlist = (e) {};
    _presenter.onErrorDeleteFromWishlist = (e) {};
    _presenter.onFinishGetWishlist = () {
      _hideLoading();
    };
    _presenter.onFinishDeleteFromWishlist = () {
      _successDelete();
    };
    _presenter.onSuccessGetWishlist = (Wishlist data) {
      _wishlist = data;
    };
    _presenter.onSuccessDeleteFromWishlist = (GeneralResponse? data) {
      _wishlistItem = data;
    };
  }

  void _successDelete() {
    _isDeleted = true;
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