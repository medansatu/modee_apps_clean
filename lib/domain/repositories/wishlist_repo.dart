import '../entitites/wishlist.dart';
import '../entitites/general_response.dart';

abstract class WishlistRepository{
  Future<Wishlist> wishlist();
}

abstract class AddWishlistRepository{
  Future<int> addWishlist(int productId);
}

abstract class DeleteWishlistRepository{
  Future<GeneralResponse> deleteWishlist(int wishlistItemId);
}