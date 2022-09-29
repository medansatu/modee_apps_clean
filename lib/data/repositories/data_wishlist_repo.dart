import 'package:dio/dio.dart';

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
  
  @override
  Future<Wishlist> wishlist() async {
    dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIyIiwibmFtZSI6InN0cmluZyIsIm5iZiI6MTY2NDM2NzUzMywiZXhwIjoxNjY0NDUzOTMzLCJpYXQiOjE2NjQzNjc1MzN9.osWVmlFBu2RFRHsKZTeSH0Rr5yZ3XkIKOgkt7nKhdKT9-aLxRcHAXg6WMfEXnX6pPK6yXah6vArNckNObP-sKA';
    try {
      print("Masuk TRY");
      final response = await dio.get(endpoints.getWishlist);
      final wishlistResponse = response.data['data'] as Map<String, dynamic>;
      Wishlist wishlist = Wishlist(
        id: wishlistResponse['id'],
        wishlistItems: wishlistResponse['wishlistItems'],
      );
      print("Selesai Get Wishlist");
      return wishlist;
    } catch (e) {
      rethrow;
    }
  }
}