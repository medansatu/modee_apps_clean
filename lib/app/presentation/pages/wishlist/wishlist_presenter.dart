import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/general_response.dart';
import '../../../../domain/entitites/wishlist.dart';
import '../../../../domain/usecases/cases/delete_from_cart_use_case.dart';
import '../../../../domain/usecases/cases/delete_from_wishlist_use_case.dart';
import '../../../../domain/usecases/cases/get_wishlist_use_case.dart';

class WishlistPresenter extends Presenter {
  late Function(Wishlist) onSuccessGetWishlist;
  late Function(dynamic error) onErrorGetWishlist;
  late Function() onFinishGetWishlist;

  late Function(GeneralResponse?) onSuccessDeleteFromWishlist;
  late Function(dynamic error) onErrorDeleteFromWishlist;
  late Function() onFinishDeleteFromWishlist;  

  final GetWishlist getWishlistUseCase;

  final DeleteWishlistUseCase deleteFromWishlistUseCase;

  WishlistPresenter({
    required this.getWishlistUseCase,
    required this.deleteFromWishlistUseCase,
  });

  void getWishlist() {
    getWishlistUseCase.execute(_GetWishlistObserver(this));
  }

  void deleteWishlist(int wishlistItemId) {
    deleteFromWishlistUseCase.execute(_DeleteFromWishlistObserver(this), DeleteWishlistParams(wishlistItemId));
  }
  
  @override
  void dispose() {
    getWishlistUseCase.dispose();
    deleteFromWishlistUseCase.dispose();
  }
}

class _GetWishlistObserver extends Observer<Wishlist> {
  final WishlistPresenter presenter;

  _GetWishlistObserver(this.presenter);
  
  @override
  void onComplete() => presenter.onFinishGetWishlist();
  
  @override
  void onError(e) => presenter.onErrorGetWishlist(e);
  
  @override
  void onNext(Wishlist? response) {
    final wishlist = response ?? Wishlist(id: 0, wishlistItems: []);
    presenter.onSuccessGetWishlist(wishlist); 
  }
}

class _DeleteFromWishlistObserver extends Observer<GeneralResponse> {
  final WishlistPresenter presenter;

  _DeleteFromWishlistObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishDeleteFromWishlist();

  @override
  void onError(e) => presenter.onErrorDeleteFromWishlist(e);

  @override
  void onNext(GeneralResponse? response) {
    final wishlistItem = response;
    presenter.onSuccessDeleteFromWishlist(wishlistItem);
  }
}