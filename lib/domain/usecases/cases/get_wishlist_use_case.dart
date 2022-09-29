import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entitites/wishlist.dart';
import '../../repositories/wishlist_repo.dart';

class GetWishlist extends UseCase<Wishlist, dynamic> {
  final WishlistRepository repository;
  
  GetWishlist(this.repository);
  
  @override
  Future<Stream<Wishlist?>> buildUseCaseStream(params) async {
    final streamController = StreamController<Wishlist>();

    try {
      final wishlist = await repository.wishlist();
      streamController.add(wishlist);
      streamController.close();      
    } catch (e, stackTrace) {
      logger.severe('StackTrace: $stackTrace');
      streamController.addError(e, stackTrace);
    }
    return streamController.stream;
  }

}