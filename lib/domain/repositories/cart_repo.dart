import '../entitites/cart.dart';

abstract class CartRepository{
  Future<Cart> cart();
}

abstract class AddCartRepository{
  Future<int> addCart(int productId);
}

abstract class DeleteCartRepository{
  Future<int> deleteCart(int cartItemId);
}