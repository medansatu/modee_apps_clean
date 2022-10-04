import 'dart:async';

import 'package:final_project_clean/domain/entitites/delete_response.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/wishlist_repo.dart';

class DeleteWishlistUseCase extends UseCase<DeleteResponse, DeleteWishlistParams> {
  final DeleteWishlistRepository repository;
  DeleteWishlistUseCase(this.repository);
  
  @override
  Future<Stream<DeleteResponse?>> buildUseCaseStream(DeleteWishlistParams? params) async {
    final streamController = StreamController<DeleteResponse>();
    try {
      final wishlistItemId = await repository.deleteWishlist(params!.wishlistItemId);
      streamController.add(wishlistItemId);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }
    return streamController.stream;
  }


}

 class DeleteWishlistParams {
    int wishlistItemId;
    DeleteWishlistParams(this.wishlistItemId);
  }
