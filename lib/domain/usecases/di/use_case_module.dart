import 'package:injector/injector.dart';

import '../cases/get_categories_use_case.dart';
import '../cases/login_use_case.dart';
import '../cases/get_products_use_case.dart';
import '../cases/get_cart_use_case.dart';
import '../cases/get_wishlist_use_case.dart';
import '../cases/add_to_cart_use_case.dart';
import '../cases/add_to_wishlist_use_case.dart';
import '../cases/register_use_case.dart';
import '../cases/delete_from_cart_use_case.dart';
import '../cases/delete_from_wishlist_use_case.dart';



class UseCaseModule {
  static registerClasses() {
    final injector = Injector.appInstance;
    injector.registerDependency<GetUser>(() => GetUser(injector.get()));
    injector.registerDependency<GetProducts>(() => GetProducts(injector.get()));
    injector.registerDependency<GetCategories>(() => GetCategories(injector.get()));
    injector.registerDependency<GetCart>(() => GetCart(injector.get()));
    injector.registerDependency<GetWishlist>(() => GetWishlist(injector.get()));
    injector.registerDependency<RegisterCase>(() => RegisterCase(injector.get()));
    injector.registerDependency<AddCartUseCase>(() => AddCartUseCase(injector.get()));
    injector.registerDependency<AddWishlistUseCase>(() => AddWishlistUseCase(injector.get()));
    injector.registerDependency<DeleteCartUseCase>(() => DeleteCartUseCase(injector.get()));
    injector.registerDependency<DeleteWishlistUseCase>(() => DeleteWishlistUseCase(injector.get()));
  }
}
