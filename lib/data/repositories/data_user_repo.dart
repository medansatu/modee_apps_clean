import 'package:dio/dio.dart';

import '../../domain/entitites/user.dart';
import '../misc/endpoints.dart';
import '../../domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final Endpoints endpoints;
  final Dio dio;

  UserRepositoryImpl({
    required this.endpoints,
    required this.dio,
  }); 

  @override
  Future<User> login(String username, String password) async {
    print("REQUEST JALAN");
    try {
      print("TRY JALAN");
      final response = await dio.post(endpoints.login,
      data: {
        "username": username,
        "password": password,
      });
      print(response);
      final userResponse = response.data["data"] as Map<String, dynamic>;
      print(userResponse["data"]);
      User user = User(
        id: userResponse["id"],
        name: userResponse["name"],
        email: userResponse["email"],
        userName: userResponse["username"],
        phoneNumber: userResponse["phoneNumber"],
        address: userResponse["address"],
        imageUrl: userResponse["imageUrl"],
        token: userResponse["token"],
      );
      print(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }}