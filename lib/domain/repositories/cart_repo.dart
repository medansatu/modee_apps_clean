import 'package:final_project_clean/domain/entitites/general_response.dart';

import '../entitites/cart.dart';

abstract class CartRepository{
  Future<Cart> cart();
}

abstract class AddCartRepository{
  Future<int> addCart(int productId);
}

abstract class DeleteCartRepository{
  Future<GeneralResponse> deleteCart(int cartItemId);
}

abstract class UpdateCartRepository{
  Future<GeneralResponse> updateCart(int cartItemId, int quantity);
}

abstract class CartTotalRepository{
  Future<int> totalCart();
}