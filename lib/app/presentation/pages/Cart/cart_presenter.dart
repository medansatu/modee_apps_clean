import 'package:final_project_clean/domain/entitites/delete_response.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/cart.dart';
import '../../../../domain/usecases/cases/get_cart_use_case.dart';
import '../../../../domain/usecases/cases/delete_from_cart_use_case.dart';


class CartPresenter extends Presenter {
  late Function(Cart) onSuccessGetCart;
  late Function(dynamic error) onErrorGetCart;
  late Function() onFinishGetCart;

  late Function(DeleteResponse?) onSuccessDeleteFromCart;
  late Function(dynamic error) onErrorDeleteFromCart;
  late Function() onFinishDeleteFromCart;  

  final GetCart getCartUseCase;
  
  final DeleteCartUseCase deleteFromCartUseCase;

  CartPresenter({
    required this.getCartUseCase,
    required this.deleteFromCartUseCase,
  });

  void getCart() {
    getCartUseCase.execute(_GetCartObserver(this));
  }

  void deleteCart(int cartItemId) {
    deleteFromCartUseCase.execute(_DeleteFromCartObserver(this), DeleteCartParams(cartItemId));
  }
  
  @override
  void dispose() {
    getCartUseCase.dispose();
    deleteFromCartUseCase.dispose();
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
    final cart = response ?? Cart(id: 0, cartItems: []);
    presenter.onSuccessGetCart(cart); 
  }
}

class _DeleteFromCartObserver extends Observer<DeleteResponse> {
  final CartPresenter presenter;

  _DeleteFromCartObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishDeleteFromCart();

  @override
  void onError(e) => presenter.onErrorDeleteFromCart(e);

  @override
  void onNext(DeleteResponse? response) {
    final cartItemId = response;
    presenter.onSuccessDeleteFromCart(cartItemId);
  }
}