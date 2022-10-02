import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './wishlist_presenter.dart';
import '../../../../domain/entitites/wishlist.dart';

class WishlistController extends Controller {
  final WishlistPresenter _presenter;

  WishlistController(this._presenter);

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

  void _initObserver() {
    _presenter.onErrorGetWishlist = (e) {};
    _presenter.onFinishGetWishlist = () {
      _hideLoading();
    };
    _presenter.onSuccessGetWishlist = (Wishlist data) {
      _wishlist = data;
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