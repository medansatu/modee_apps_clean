import 'package:dio/dio.dart';

import '../misc/endpoints.dart';
import '../../domain/entitites/cart.dart';
import '../../domain/repositories/cart_repo.dart';

class CartRepositoryImpl implements CartRepository {
  final Endpoints endpoints;
  final Dio dio;

  CartRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });
  
  @override
  Future<Cart> cart() async {
    dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIyIiwibmFtZSI6InN0cmluZyIsIm5iZiI6MTY2NDM2NzUzMywiZXhwIjoxNjY0NDUzOTMzLCJpYXQiOjE2NjQzNjc1MzN9.osWVmlFBu2RFRHsKZTeSH0Rr5yZ3XkIKOgkt7nKhdKT9-aLxRcHAXg6WMfEXnX6pPK6yXah6vArNckNObP-sKA';
    try {
      print("Masuk TRY");
      final response = await dio.get(endpoints.getCart);
      final cartResponse = response.data['data'] as Map<String, dynamic>;
      Cart cart = Cart(
        id: cartResponse['id'],
        cartItems: cartResponse['cartItems'],
      );
      print("Selesai Get Cart");
      return cart;
    } catch (e) {
      rethrow;
    }
  }
}