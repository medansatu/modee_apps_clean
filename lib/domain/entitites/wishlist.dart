class Wishlist {
  final int id;
  final List? wishlistItems;

  Wishlist({required this.id, this.wishlistItems});

  factory Wishlist.fromResponse(Map<String, dynamic> response) {
    final id = response['id'] ?? 0;
    final wishlistItems = response['wishlistItems'];
    return Wishlist(
      id: id,
      wishlistItems: wishlistItems,
    );
  }
}
