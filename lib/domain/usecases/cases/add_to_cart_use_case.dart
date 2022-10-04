import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/cart_repo.dart';

class AddCartUseCase extends UseCase<int, AddCartParams> {
  final AddCartRepository repository;

  AddCartUseCase(this.repository);
  
  @override
  Future<Stream<int?>> buildUseCaseStream(AddCartParams? params) async {    
    final streamController = StreamController<int>();
    try {
      final cartItemId = await repository.addCart(params!.productId);
      streamController.add(cartItemId);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }

    return streamController.stream;
  }
  }

  class AddCartParams {
    int productId;
    AddCartParams(this.productId);
  }
