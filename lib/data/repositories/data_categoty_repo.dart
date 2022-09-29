import 'package:dio/dio.dart';

import '../../domain/repositories/category_repo.dart';
import '../../domain/entitites/category.dart';
import '../../data/misc/endpoints.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Endpoints endpoints;
  final Dio dio;

  CategoryRepositoryImpl({required this.endpoints, required this.dio});

  @override
  Future<List<Category>> categories() async {
    try {
      final response = await dio.get(endpoints.getAllCategory);
    final categoryResponse = response.data['data'] as List<dynamic>;
    final categories = categoryResponse
        .map((dynamic response) => Category.fromResponse(response))
        .toList();
        return categories;      
    } catch (e) {
      rethrow;
    }    
  }
}
