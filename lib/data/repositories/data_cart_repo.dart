import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();       
    final token = prefs.getString("token");
    return token;
  }

  Future<String?> _getProducts() async {
    final prefs = await SharedPreferences.getInstance();       
    final products = prefs.getString("products");
    return products;
  }
  
  
  @override
  Future<Cart> cart() async {
    String? token;
    String? products;
    await _getToken().then((value) {
      token = value;
    });

    await _getProducts().then((value) => products = value);

    print(products);

    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      print("Masuk TRY");
      final response = await dio.get(endpoints.getCart);
      final cartResponse = response.data['data'] as Map<String, dynamic>;
      Cart cart = Cart(
        id: cartResponse['id'],
        cartItems: cartResponse['cartItems'],
        products: products,
      );
      print("Selesai Get Cart");
      return cart;
    } catch (e) {
      rethrow;
    }
  }

}