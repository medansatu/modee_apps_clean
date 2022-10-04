import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecases/cases/add_to_cart_use_case.dart';
import '../../../../domain/usecases/cases/add_to_wishlist_use_case.dart';

class ProductDetailPresenter extends Presenter {  
  late Function(int?) onSuccessAddToCart;
  late Function(dynamic error) onErrorAddtoCart;
  late Function() onFinishAddtoCart;

  late Function(int?) onSuccessAddToWishlist;
  late Function(dynamic error) onErrorAddtoWishlist;
  late Function() onFinishAddtoWishlist;

  final AddCartUseCase addToCartUseCase;
  final AddWishlistUseCase addToWishlistUseCase;

  ProductDetailPresenter({required this.addToCartUseCase, required this.addToWishlistUseCase});

  void addToCart(int productId) {
    addToCartUseCase.execute(_AddToCartObserver(this), AddCartParams(productId));
  }

  void addToWishlist(int productId) {
    addToWishlistUseCase.execute(_AddToWishlistObserver(this), AddWishlistParams(productId));
  }
  
  @override
  void dispose() {
    addToCartUseCase.dispose();
    addToWishlistUseCase.dispose();
  }  


}

class _AddToCartObserver extends Observer<int> {
  final ProductDetailPresenter presenter;

  _AddToCartObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishAddtoCart();

  @override
  void onError(e) => presenter.onErrorAddtoCart(e);

  @override
  void onNext(int? response) {
    final cartItemId = response;
    presenter.onSuccessAddToCart(cartItemId);
  }
}

class _AddToWishlistObserver extends Observer<int> {
  final ProductDetailPresenter presenter;

  _AddToWishlistObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishAddtoWishlist();

  @override
  void onError(e) => presenter.onErrorAddtoWishlist(e);

  @override
  void onNext(int? response) {
    final wishlistItemId = response;
    presenter.onSuccessAddToWishlist(wishlistItemId);
  }
}