class User {
  final int id;
  final String? name, userName, email, address, phoneNumber, imageUrl, token, message;
  final bool? success;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.address,
    required this.phoneNumber,
    this.imageUrl,
    required this.token,
    required this.success,
    this.message,
  });

  factory User.fromResponse(Map<String, dynamic> response) {
    final id = response["data"]["id"] ?? 0;
    final name = response["data"]["name"] ?? "";
    final email = response["data"]["email"] ?? "";
    final userName = response["data"]["username"] ?? "";
    final address = response["data"]["address"] ?? "";
    final phoneNumber = response["data"]["phoneNumber"] ?? "";
    final imageUrl = response["data"]["imageUrl"] ?? "";
    final token = response["data"]["token"] ?? "";
    final success = response["success"] ?? false;
    final message = response["message"] ?? "";

    return User(
      id: id,
      name: name,
      email: email,
      userName: userName,
      address: address,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      token: token,
      success: success,
      message: message,
    );
  }
}
