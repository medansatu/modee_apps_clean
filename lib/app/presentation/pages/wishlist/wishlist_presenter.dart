import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/wishlist.dart';
import '../../../../domain/usecases/cases/get_wishlist_use_case.dart';

class WishlistPresenter extends Presenter {
  late Function(Wishlist) onSuccessGetWishlist;
  late Function(dynamic error) onErrorGetWishlist;
  late Function() onFinishGetWishlist;

  final GetWishlist getWishlistUseCase;

  WishlistPresenter({
    required this.getWishlistUseCase,
  });

  void getWishlist() {
    getWishlistUseCase.execute(_GetWishlistObserver(this));
  }
  
  @override
  void dispose() {
    getWishlistUseCase.dispose();
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
    final wishlist = response ?? Wishlist(id: 0);
    presenter.onSuccessGetWishlist(wishlist); 
  }
}