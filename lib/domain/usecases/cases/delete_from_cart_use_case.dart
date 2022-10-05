import 'dart:async';

import 'package:final_project_clean/domain/entitites/general_response.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/cart_repo.dart';

class DeleteCartUseCase extends UseCase<GeneralResponse, DeleteCartParams> {
  final DeleteCartRepository repository;
  DeleteCartUseCase(this.repository);
  
  @override
  Future<Stream<GeneralResponse?>> buildUseCaseStream(DeleteCartParams? params) async {
    final streamController = StreamController<GeneralResponse>();
    try {
      final cartItemId = await repository.deleteCart(params!.cartItemId);
      streamController.add(cartItemId);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }
    return streamController.stream;
  }


}

 class DeleteCartParams {
    int cartItemId;
    DeleteCartParams(this.cartItemId);
  }
