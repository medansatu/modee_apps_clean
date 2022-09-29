class Category {
  final int id;
  final String? category, imageUrl;

  Category({
    required this.id,
    required this.category,
    this.imageUrl,
  });

  factory Category.fromResponse(Map<String, dynamic> response) {
    final id = response['id'] ?? 0;
    final category = response['category'] ?? '';
    final imageUrl = response['imageURL'] ?? '';

    return Category(
      id: id,
      category: category,
      imageUrl: imageUrl,
    );
  }
}
