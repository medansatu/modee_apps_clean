import 'package:final_project_clean/domain/entitites/delete_response.dart';

import '../entitites/cart.dart';

abstract class CartRepository{
  Future<Cart> cart();
}

abstract class AddCartRepository{
  Future<int> addCart(int productId);
}

abstract class DeleteCartRepository{
  Future<DeleteResponse> deleteCart(int cartItemId);
}