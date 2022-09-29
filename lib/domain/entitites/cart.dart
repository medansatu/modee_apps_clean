class Cart {
  final int id;
  final List? cartItems;

  Cart({required this.id, this.cartItems});

  factory Cart.fromResponse(Map<String, dynamic> response) {
    final id = response['id'] ?? 0;
    final cartItems = response['cartItems'];
    return Cart(
      id: id,
      cartItems: cartItems,
    );
  }
}
