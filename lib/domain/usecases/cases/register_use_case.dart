import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entitites/register.dart';
import '../../repositories/register_repo.dart';

class RegisterCase extends UseCase<Register, RegisterParams> {
  final RegisterRepository repository;
  
  RegisterCase(this.repository);
  
  @override
  Future<Stream<Register?>> buildUseCaseStream(params) async {
    final streamController = StreamController<Register>();

    try {
      final register = await repository.register(params!.name, params.username, params.email, params.phoneNumber, params.address, params.password);
      streamController.add(register);
      streamController.close();
    } catch (e, stackTrace) {
      logger.severe("Stacktrace: $stackTrace");
      streamController.addError(e);
    }
    return streamController.stream;
  }
}

class RegisterParams {
  String name, username, email, phoneNumber, address, password;

  RegisterParams({
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
  });
}

