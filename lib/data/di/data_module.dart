import 'package:final_project_clean/domain/repositories/profile_repo.dart';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

import '../misc/endpoints.dart';
import '../misc/logging_interceptor.dart';
import '../repositories/data_user_repo.dart';
import '../../domain/repositories/user_repo.dart';
import '../../domain/repositories/category_repo.dart';
import '../../domain/repositories/product_repo.dart';
import '../../domain/repositories/cart_repo.dart';
import '../../domain/repositories/wishlist_repo.dart';
import '../../domain/repositories/register_repo.dart';
import '../../data/repositories/data_categoty_repo.dart';
import '../../data/repositories/data_product_repo.dart';
import '../../data/repositories/data_cart_repo.dart';
import '../../data/repositories/data_wishlist_repo.dart';
import '../../data/repositories/data_register_repo.dart';
import '../../data/repositories/data_profile_repo.dart';
import '../../app/constant.dart';

class DataModule {
  static registerClasses() {
    final injector = Injector.appInstance;
    injector.registerSingleton<Endpoints>(() => Endpoints());
    injector.registerDependency<Dio>(() {
      final dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.sendTimeout = 30 * 1000;
      dio.options.connectTimeout = 30 * 1000;
      dio.options.receiveTimeout = 30 * 1000;

      if (kDebugMode) dio.interceptors.add(LoggingInterceptor());

      return dio;
    });
    injector.registerDependency<UserRepository>(() => UserRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<ProductRepository>(() => ProductRepositoryImpl(dio: injector.get(), endpoints: injector.get()));
    injector.registerDependency<CategoryRepository>(() => CategoryRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<CartRepository>(() => CartRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<WishlistRepository>(() => WishlistRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<RegisterRepository>(() => RegisterRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<AddCartRepository>(() => AddCartRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<AddWishlistRepository>(() => AddWishlistRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<DeleteCartRepository>(() => DeleteCartRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<DeleteWishlistRepository>(() => DeleteWishlistRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<ProfileRepository>(() => ProfileRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<UpdateCartRepository>(() => UpdateCartRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
    injector.registerDependency<CartTotalRepository>(() => CartTotalRepositoryImpl(endpoints: injector.get(), dio: injector.get()));
  }
}