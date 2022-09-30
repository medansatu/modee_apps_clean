import 'package:injector/injector.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../presentation/pages/login/login_controller.dart';
import '../presentation/pages/login/login_presenter.dart';
import '../presentation/pages/Home/home_controller.dart';
import '../presentation/pages/Home/home_presenter.dart';
import '../presentation/pages/Cart/cart_controller.dart';
import '../presentation/pages/Cart/cart_presenter.dart';
import '../presentation/pages/wishlist/wishlist_controller.dart';
import '../presentation/pages/wishlist/wishlist_presenter.dart';
import '../presentation/pages/Register/register_controller.dart';
import '../presentation/pages/Register/register_presenter.dart';
import '../presentation/pages/CategoryItems/category_items_controller.dart';
import '../presentation/pages/ProductDetail/product_detail_controller.dart';
import '../presentation/pages/Tabs/tabs_controller.dart';
import '../../data/di/data_module.dart';
import '../../domain/usecases/di/use_case_module.dart';
import '../navigator.dart';

class AppModule {
  static registerClasses() {
    final injector = Injector.appInstance;
    injector.registerDependency<LoginPresenter>(
      () => LoginPresenter(getUsersUseCase: injector.get()),
    );
    injector.registerDependency<LoginController>(
      () => LoginController(injector.get()),
    );
    injector.registerDependency<HomeController>(
      () => HomeController(injector.get()),
    );
    injector.registerDependency<HomePresenter>(
      () => HomePresenter(
          getCategoriesUseCase: injector.get(),
          getProductsUseCase: injector.get()),
    );
    injector.registerDependency<CartController>(
      () => CartController(injector.get()),
    );
    injector.registerDependency<CartPresenter>(
      () => CartPresenter(getCartUseCase: injector.get()),
    );
    injector.registerDependency<WishlistController>(
      () => WishlistController(injector.get()),
    );
    injector.registerDependency<WishlistPresenter>(
      () => WishlistPresenter(getWishlistUseCase: injector.get()),
    );
    injector.registerDependency<RegisterController>(
      () => RegisterController(injector.get()),
    );
    injector.registerDependency<RegisterPresenter>(
      () => RegisterPresenter(registerUseCase: injector.get()),
    );
    injector.registerDependency<CategoryItemsController>(() => CategoryItemsController());
    injector.registerDependency<ProductDetailController>(() => ProductDetailController());
    injector.registerDependency<TabsController>(() => TabsController());

    // Navigator
    injector.registerSingleton<AppNavigator>(
      () => AppNavigator(),
    );
  }

  static init() {
    DataModule.registerClasses();
    UseCaseModule.registerClasses();
    registerClasses();
  }
}
