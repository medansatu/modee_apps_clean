import 'package:dio/dio.dart';
import 'package:final_project_clean/domain/entitites/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entitites/delete_response.dart';
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
        products: Product.decode(products.toString()),
      );
      print("Selesai Get Wishlist");
      return wishlist;
    } catch (e) {
      rethrow;
    }
  }
}

class AddWishlistRepositoryImpl implements AddWishlistRepository {
  final Endpoints endpoints;
  final Dio dio;

  AddWishlistRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();       
    final token = prefs.getString("token");
    return token;
  }
  
  @override
  Future<int> addWishlist(int productId) async {
    String? token;

    await _getToken().then((value) {
      token = value;
    });

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
       print("TRY JALAN");
      final response = await dio.post(endpoints.addToWishlist,
      data: {
        "productId": productId
      });
      print(response);
      final addToWishlistResponse = response.data as Map<String, dynamic>;
      int wishlistItemId = addToWishlistResponse['data']['id'];
      print("SUKSES ADD TO WISHLIST");
      return wishlistItemId;
    } catch (e) {
      rethrow;
    }
  }
}

class DeleteWishlistRepositoryImpl implements DeleteWishlistRepository {
  final Endpoints endpoints;
  final Dio dio;

  DeleteWishlistRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();       
    final token = prefs.getString("token");
    return token;
  }
  
  @override
  Future<DeleteResponse> deleteWishlist(int wishlistItemId) async {
    String? token;
    String? id;

    id = wishlistItemId.toString();

    await _getToken().then((value) {
      token = value;
    });

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      print("TRY JALAN");
      final response = await dio.delete(endpoints.deleteWishlist+"?id="+id);
      print(response);
      final deleteFromWishlistResponse = response.data as Map<String, dynamic>;
      DeleteResponse deleteResponse = DeleteResponse(id: deleteFromWishlistResponse['data']['id'], success: deleteFromWishlistResponse['success']);
      print(deleteResponse.success);
      print("SUKSES DELETE FROM WISHLIST");
      return deleteResponse;
    } catch (e) {
      rethrow;
    }
  }
}