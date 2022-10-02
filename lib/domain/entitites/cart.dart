class Cart {
  final int id;
  final List cartItems;
  final String? products;

  Cart({required this.id, required this.cartItems, this.products});

  factory Cart.fromResponse(Map<String, dynamic> response) {
    final id = response['id'] ?? 0;
    final cartItems = response['cartItems'];
    return Cart(
      id: id,
      cartItems: cartItems, 
    );     
  }
}
