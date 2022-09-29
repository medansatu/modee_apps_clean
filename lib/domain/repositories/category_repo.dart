import '../entitites/category.dart';

abstract class CategoryRepository{
  Future<List<Category>> categories();
}