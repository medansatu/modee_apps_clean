import '../entitites/product.dart';

abstract class ProductRepository{
  Future<List<Product>> products();
}