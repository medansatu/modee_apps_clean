import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/misc/endpoints.dart';
import '../../domain/entitites/product.dart';
import '../../domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Endpoints endpoints;
  final Dio dio;

  ProductRepositoryImpl({
    required this.dio,
    required this.endpoints,
  });
  

  @override
  Future<List<Product>> products() async {    
    try {
      print("Masuk TRY");      
      final response = await dio.get(endpoints.getAllProduct);
      final productsResponse = response.data["data"] as List<dynamic>;
      final products = productsResponse
          .map(
            (dynamic response) => Product.fromResponse(response),
          )
          .toList();
          final prefs = await SharedPreferences.getInstance(); 
          var encodedData = Product.encode(products);
          await prefs.setString("products", encodedData);
          print("ENCODED: $encodedData");
          print("Selesai Get Product");
          return products;
    } catch (e) {
      rethrow;
    }
  }
}
