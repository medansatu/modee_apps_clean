import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entitites/general_response.dart';
import '../../repositories/cart_repo.dart';

class UpdateCartUseCase extends UseCase<GeneralResponse, UpdateCartParams> {
  final UpdateCartRepository repository;
  UpdateCartUseCase(this.repository);
  
  @override
  Future<Stream<GeneralResponse?>> buildUseCaseStream(UpdateCartParams? params) async {
    final streamController = StreamController<GeneralResponse>();
    try {
      final updateResponse = await repository.updateCart(params!.cartItemId, params.quantity);
      streamController.add(updateResponse);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }
    return streamController.stream;
  }
}

class UpdateCartParams {
    int cartItemId;
    int quantity;
    UpdateCartParams(this.cartItemId, this.quantity);
  }