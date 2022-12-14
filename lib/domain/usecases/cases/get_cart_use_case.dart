import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/cart_repo.dart';
import '../../entitites/cart.dart';


class GetCart extends UseCase<Cart, dynamic> {
  final CartRepository repository;

  GetCart(this.repository);
  
  @override
  Future<Stream<Cart?>> buildUseCaseStream(params) async {
    final streamController = StreamController<Cart>();
    try {
      final cart = await repository.cart();
      streamController.add(cart);
      streamController.close();      
    } catch (e, stackTrace) {
      logger.severe("Stacktrace: $stackTrace");
      streamController.addError(e, stackTrace);      
    }
    return streamController.stream;
  }
}