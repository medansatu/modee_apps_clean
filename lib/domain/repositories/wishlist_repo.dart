import '../entitites/wishlist.dart';

abstract class WishlistRepository{
  Future<Wishlist> wishlist();
}

abstract class AddWishlistRepository{
  Future<int> addWishlist(int productId);
}