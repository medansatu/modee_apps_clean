import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entitites/category.dart';
import '../../repositories/category_repo.dart';

class GetCategories extends UseCase<List<Category>, dynamic> {
  final CategoryRepository repository;

  GetCategories(this.repository);

  @override
  Future<Stream<List<Category>?>> buildUseCaseStream(params) async {
    final streamController = StreamController<List<Category>>();

    try {
      final category = await repository.categories();
      streamController.add(category);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe("Stacktrace: $stackTrace");
      streamController.addError(e, stackTrace);
    }
    return streamController.stream;
  }
}
