import 'package:final_project_clean/domain/repositories/product_repo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'dart:async';

import '../../repositories/product_repo.dart';
import '../../entitites/product.dart';

class GetProducts extends UseCase<List<Product>, dynamic> {
  final ProductRepository repository;

  GetProducts(this.repository);
  
  @override
  Future<Stream<List<Product>?>> buildUseCaseStream(params) async {
    final streamController = StreamController<List<Product>>();

    try {
      final products = await repository.products();
      streamController.add(products);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe("Stacktrace: $stackTrace");
      streamController.addError(e, stackTrace);      
    }

    return streamController.stream;
  }
}
