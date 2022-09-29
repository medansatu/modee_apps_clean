import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/cart.dart';
import '../../../../domain/usecases/cases/get_cart_use_case.dart';

class CartPresenter extends Presenter {
  late Function(Cart) onSuccessGetCart;
  late Function(dynamic error) onErrorGetCart;
  late Function() onFinishGetCart;

  final GetCart getCartUseCase;

  CartPresenter({
    required this.getCartUseCase,
  });

  void getCart() {
    getCartUseCase.execute(_GetCartObserver(this));
  }
  
  @override
  void dispose() {
    getCartUseCase.dispose();
  }
}

class _GetCartObserver extends Observer<Cart> {
  final CartPresenter presenter;

  _GetCartObserver(this.presenter);
  
  @override
  void onComplete() => presenter.onFinishGetCart();
  
  @override
  void onError(e) => presenter.onErrorGetCart(e);
  
  @override
  void onNext(Cart? response) {
    final cart = response ?? Cart(id: 0);
    presenter.onSuccessGetCart(cart); 
  }
}