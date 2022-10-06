import 'package:final_project_clean/domain/usecases/cases/update_cart_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/cart.dart';
import '../../../../domain/usecases/cases/get_cart_use_case.dart';
import '../../../../domain/usecases/cases/delete_from_cart_use_case.dart';
import '../../../../domain/entitites/general_response.dart';
import '../../../../domain/usecases/cases/get_total_cart_use_case.dart';


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

  late Function(int) onSuccessGetCartTotal;
  late Function(dynamic error) onErrorGetCartTotal;
  late Function() onFinishGetCartTotal;  

  final GetCart getCartUseCase;
  
  final DeleteCartUseCase deleteFromCartUseCase;

  final UpdateCartUseCase updateCartUseCase;

  final GetCartTotalUseCase getCartTotalUseCase;

  CartPresenter({
    required this.getCartUseCase,
    required this.deleteFromCartUseCase,
    required this.updateCartUseCase,
    required this.getCartTotalUseCase,
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

  void getCartTotal() {
    getCartTotalUseCase.execute(_GetCartTotalObserver(this));
  }
  
  @override
  void dispose() {
    getCartUseCase.dispose();
    deleteFromCartUseCase.dispose();
    updateCartUseCase.dispose();
    getCartTotalUseCase.dispose();
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

class _GetCartTotalObserver extends Observer<int> {
  final CartPresenter presenter;

  _GetCartTotalObserver(this.presenter);
  
  @override
  void onComplete() {
    presenter.onFinishGetCartTotal();
  }
  
  @override
  void onError(e) {
    presenter.onErrorGetCartTotal(e);
  }
  
  @override
  void onNext(int? response) {
    final cartTotal = response ?? 0;
    presenter.onSuccessGetCartTotal(cartTotal);
  }
  
  
}