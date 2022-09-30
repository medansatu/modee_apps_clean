class Register {
  final int id;

  Register({
    required this.id
  });

  factory Register.fromResponse(int response) {
    final id = response;
    return Register(id: id);
  }
}