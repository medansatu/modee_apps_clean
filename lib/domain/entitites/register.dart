class Register {
  final int id;

  Register({
    required this.id
  });

  factory Register.fromResponse(int response) {
    final id = response ?? 0;
    return Register(id: id);
  }
}