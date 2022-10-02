import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../misc/endpoints.dart';
import '../../domain/repositories/wishlist_repo.dart';
import '../../domain/entitites/wishlist.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final Endpoints endpoints;
  final Dio dio;

  WishlistRepositoryImpl({
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
  Future<Wishlist> wishlist() async {
    String? token;
    String? products;
    await _getToken().then((value) {
      token = value;
    });

    await _getProducts().then((value) => products = value);

    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      print("Masuk TRY");
      final response = await dio.get(endpoints.getWishlist);
      final wishlistResponse = response.data['data'] as Map<String, dynamic>;
      Wishlist wishlist = Wishlist(
        id: wishlistResponse['id'],
        wishlistItems: wishlistResponse['wishlistItems'],
        products: products,
      );
      print("Selesai Get Wishlist");
      return wishlist;
    } catch (e) {
      rethrow;
    }
  }
}