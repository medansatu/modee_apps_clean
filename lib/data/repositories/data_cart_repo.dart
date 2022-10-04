import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../misc/endpoints.dart';
import '../../domain/entitites/cart.dart';
import '../../domain/repositories/cart_repo.dart';
import '../../domain/entitites/product.dart';

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
        products: Product.decode(products.toString()),
      );
      print("Selesai Get Cart");
      return cart;
    } catch (e) {
      rethrow;
    }
  }

}

class AddCartRepositoryImpl implements AddCartRepository {
  final Endpoints endpoints;
  final Dio dio;

  AddCartRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();       
    final token = prefs.getString("token");
    return token;
  }
  
  @override
  Future<int> addCart(int productId) async {
    String? token;

    await _getToken().then((value) {
      token = value;
    });

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
       print("TRY JALAN");
      final response = await dio.post(endpoints.addToCart,
      data: {
        "productId": productId
      });
      print(response);
      final addToCartResponse = response.data as Map<String, dynamic>;
      int cartItemId = addToCartResponse['data']['id'];
      print("SUKSES ADD TO CART");
      return cartItemId;
    } catch (e) {
      rethrow;
    }
  }
}

class DeleteCartRepositoryImpl implements DeleteCartRepository {
  final Endpoints endpoints;
  final Dio dio;

  DeleteCartRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();       
    final token = prefs.getString("token");
    return token;
  }
  
  @override
  Future<int> deleteCart(int cartItemId) async {
    String? token;
    String? id;

    id = cartItemId.toString();

    await _getToken().then((value) {
      token = value;
    });

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      print("TRY JALAN");
      final response = await dio.delete(endpoints.deleteCartItem+"?id="+id);
      print(response);
      final deleteToCartResponse = response.data as Map<String, dynamic>;
      int cartItemId = deleteToCartResponse['data']['id'];
      print(cartItemId);
      print("SUKSES DELETE FROM CART");
      return cartItemId;
    } catch (e) {
      rethrow;
    }
  }
}