import 'package:final_project_clean/domain/entitites/category.dart';
import 'package:flutter/cupertino.dart';

class Product {
  final int id;
  final String? productName, description, imageUrl;
  final int? price, stock;
  final Map<String, dynamic> category;

  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.stock,
    this.imageUrl,
    required this.category,
  });

  factory Product.fromResponse(Map<String, dynamic> response) {
    final id = response["id"] ?? 0;
    final price = response["price"] ?? 0;
    final stock = response["stock"] ?? 0;
    final productName = response["productName"] ?? "";
    final description = response["description"] ?? "";
    final imageUrl = response["imageURL"] ?? "";    
    final category = response["category"];

    return Product(
      id: id,
      productName: productName,
      description: description,
      price: price,
      stock: stock,
      imageUrl: imageUrl,
      category: category
    );
  }
}
