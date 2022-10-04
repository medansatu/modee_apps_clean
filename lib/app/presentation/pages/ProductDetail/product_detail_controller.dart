import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
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
  }

  void addToWishlist(int productId) {
    _presenter.addToWishlist(productId);
  }


  void _initObserver() {
    _presenter.onErrorAddtoCart = (e) {
      // _hideLoading();
    };
    _presenter.onErrorAddtoWishlist = (e) {};
    _presenter.onFinishAddtoCart = () {
      // _hideLoading();
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