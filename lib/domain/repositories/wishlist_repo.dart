import '../entitites/wishlist.dart';

abstract class WishlistRepository{
  Future<Wishlist> wishlist();
}