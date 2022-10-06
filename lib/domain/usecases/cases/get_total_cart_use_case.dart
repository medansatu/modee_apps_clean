import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/cart_repo.dart';

class GetCartTotalUseCase extends UseCase<int, dynamic> {
  final CartTotalRepository repository;

  GetCartTotalUseCase(this.repository);
  
  @override
  Future<Stream<int?>> buildUseCaseStream(params) async {
    final streamController = StreamController<int>();
    try {
      final cartTotal = await repository.totalCart();
      streamController.add(cartTotal);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe("Stacktrace: $stackTrace");
      streamController.addError(e, stackTrace);      
    }
    return streamController.stream;
  }
}