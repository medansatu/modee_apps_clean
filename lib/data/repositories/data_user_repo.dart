import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final userResponse = response.data as Map<String, dynamic>;      
      
      User user = User(
        id: userResponse["data"]["id"],
        name: userResponse["data"]["name"],
        email: userResponse["data"]["email"],
        userName: userResponse["data"]["username"],
        phoneNumber: userResponse["data"]["phoneNumber"],
        address: userResponse["data"]["address"],
        imageUrl: userResponse["data"]["imageUrl"],
        token: userResponse["data"]["token"],
        success: userResponse["success"],
        message: userResponse["message"],
      );
      final prefs = await SharedPreferences.getInstance(); 
      await prefs.setString("token", user.token.toString());
      var tokens = prefs.getString("token");
      print(tokens);
      print(user.name);
      print(user.success);
      print(user.message);
      print("SELESAI LOGIN");
      return user;
    } catch (e) {
      if (e is DioError) {
        print("Errornya: ${e.message}");
      }
      rethrow;
    }
  }}