import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/wishlist_repo.dart';

class AddWishlistUseCase extends UseCase<int, AddWishlistParams> {
  final AddWishlistRepository repository;

  AddWishlistUseCase(this.repository);
  
  @override
  Future<Stream<int?>> buildUseCaseStream(AddWishlistParams? params) async {    
    final streamController = StreamController<int>();
    try {
      final wishlistItemId = await repository.addWishlist(params!.productId);
      streamController.add(wishlistItemId);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe('Stacktrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }

    return streamController.stream;
  }
  }

  class AddWishlistParams {
    int productId;
    AddWishlistParams(this.productId);
  }
