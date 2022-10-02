class Wishlist {
  final int id;
  final List wishlistItems;
  final String? products;

  Wishlist({required this.id, required this.wishlistItems, this.products});

  factory Wishlist.fromResponse(Map<String, dynamic> response) {
    final id = response['id'] ?? 0;
    final wishlistItems = response['wishlistItems'];
    return Wishlist(
      id: id,
      wishlistItems: wishlistItems,
    );
  }
}
