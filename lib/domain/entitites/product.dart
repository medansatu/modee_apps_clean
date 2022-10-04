import 'dart:convert';

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
        category: category);
  }

  static Map<String, dynamic> toMap(Product product) {
    return {
      'id': product.id,
      'productName': product.productName,
      'description': product.description,
      'price': product.price,
      'stock': product.stock,
      'imageUrl': product.imageUrl,
      'category': product.category
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      productName: map['productName'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      stock: map['stock'] as int,
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as Map<String, dynamic>
    );
  }

  static String encode(List<Product> products) {
    List<Map<String, dynamic>> jsonData = products.map((product) => Product.toMap(product)).toList();
    return jsonEncode(jsonData);
  }

  static List<Product> decode(String products) => (json.decode(products) as List<dynamic>).map((product) => Product.fromJson(product)).toList();
}
