import '../entitites/cart.dart';

abstract class CartRepository{
  Future<Cart> cart();
}