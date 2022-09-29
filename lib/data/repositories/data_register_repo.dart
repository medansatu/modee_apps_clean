import 'package:dio/dio.dart';

import '../misc/endpoints.dart';
import '../../domain/entitites/register.dart';
import '../../domain/repositories/register_repo.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final Endpoints endpoints;
  final Dio dio;

  RegisterRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });
  
  @override
  Future<Register> register(String name, String username, String email, String phoneNumber, String address, String password) async {
    try {
      final response = await dio.post(endpoints.register,
      data: {
        "name" : name,
        "username" : username,
        "email" : email,
        "phoneNumber" : phoneNumber,
        "address" : address,
        "password" : password,
      });
      final registerResponse = response.data['data'];
      Register register = Register(id: registerResponse);
      return register;
    } catch (e) {
      rethrow;
    }
  }
}