import 'package:final_project_clean/domain/usecases/cases/update_cart_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/cart.dart';
import '../../../../domain/usecases/cases/get_cart_use_case.dart';
import '../../../../domain/usecases/cases/delete_from_cart_use_case.dart';
import '../../../../domain/entitites/general_response.dart';


class CartPresenter extends Presenter {
  late Function(Cart) onSuccessGetCart;
  late Function(dynamic error) onErrorGetCart;
  late Function() onFinishGetCart;

  late Function(GeneralResponse?) onSuccessDeleteFromCart;
  late Function(dynamic error) onErrorDeleteFromCart;
  late Function() onFinishDeleteFromCart; 

  late Function(GeneralResponse?) onSuccessUpdateCart;
  late Function(dynamic error) onErrorUpdateCart;
  late Function() onFinishUpdateCart;  

  final GetCart getCartUseCase;
  
  final DeleteCartUseCase deleteFromCartUseCase;

  final UpdateCartUseCase updateCartUseCase;

  CartPresenter({
    required this.getCartUseCase,
    required this.deleteFromCartUseCase,
    required this.updateCartUseCase,
  });

  void getCart() {
    getCartUseCase.execute(_GetCartObserver(this));
  }

  void deleteCart(int cartItemId) {
    deleteFromCartUseCase.execute(_DeleteFromCartObserver(this), DeleteCartParams(cartItemId));
  }

  void updateCart(int cartItemId, int quantity) {
    updateCartUseCase.execute(_UpdateCartObserver(this), UpdateCartParams(cartItemId, quantity));
  }
  
  @override
  void dispose() {
    getCartUseCase.dispose();
    deleteFromCartUseCase.dispose();
    updateCartUseCase.dispose();
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

class _DeleteFromCartObserver extends Observer<GeneralResponse> {
  final CartPresenter presenter;

  _DeleteFromCartObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishDeleteFromCart();

  @override
  void onError(e) => presenter.onErrorDeleteFromCart(e);

  @override
  void onNext(GeneralResponse? response) {
    final cartItemId = response;
    presenter.onSuccessDeleteFromCart(cartItemId);
  }
}

class _UpdateCartObserver extends Observer<GeneralResponse> {
  final CartPresenter presenter;

  _UpdateCartObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishUpdateCart();

  @override
  void onError(e) => presenter.onErrorUpdateCart(e);

  @override
  void onNext(GeneralResponse? response) {
    final updateResponse = response;
    presenter.onSuccessUpdateCart(updateResponse);
  }
}