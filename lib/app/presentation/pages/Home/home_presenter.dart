import 'package:final_project_clean/domain/entitites/category.dart';
import 'package:final_project_clean/domain/usecases/cases/get_categories_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entitites/product.dart';
import '../../../../domain/usecases/cases/get_products_use_case.dart';

class HomePresenter extends Presenter {
  late Function(List<Product>) onSuccessGetProducts;
  late Function(dynamic error) onErrorGetProducts;
  late Function() onFinishGetProducts;

  //Category
  late Function(List<Category>) onSuccessGetCategories;
  late Function(dynamic error) onErrorGetCategories;
  late Function() onFinishGetCategories;

  final GetProducts getProductsUseCase;

  //Category
  final GetCategories getCategoriesUseCase;

  HomePresenter({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  });

  void getProducts() {
    getProductsUseCase.execute(_GetProductsObserver(this));
  }

  //Category
  void getCategories() {
    getCategoriesUseCase.execute(_GetCategoriesObserver(this));
  }

  @override
  void dispose() {
    getProductsUseCase.dispose();
    getCategoriesUseCase.dispose();
  }
  
}

class _GetProductsObserver extends Observer<List<Product>> {
  final HomePresenter presenter;

  _GetProductsObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishGetProducts();

  @override
  void onError(e) => presenter.onErrorGetProducts(e);

  @override
  void onNext(List<Product>? response) {
    final products = response ?? [];
    presenter.onSuccessGetProducts(products);
  }
}

class _GetCategoriesObserver extends Observer<List<Category>> {
  final HomePresenter presenter;

  _GetCategoriesObserver(this.presenter);

  @override
  void onComplete() => presenter.onFinishGetCategories();

  @override
  void onError(e) => presenter.onErrorGetCategories(e);

  @override
  void onNext(List<Category>? response) {
    final categories = response ?? [];
    presenter.onSuccessGetCategories(categories);
  }
}
