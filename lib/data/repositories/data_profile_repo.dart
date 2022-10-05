import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entitites/profile.dart';
import '../misc/endpoints.dart';
import '../../domain/repositories/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Endpoints endpoints;
  final Dio dio;

  ProfileRepositoryImpl({
    required this.endpoints,
    required this.dio,
  });

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return token;
  }

  @override
  Future<Profile> profile() async {
    String? token;

    await _getToken().then((value) => token = value);

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      print("TRY GET PROFILE");
      final response = await dio.get(endpoints.profile);
      final profileResponse = response.data['data'] as Map<String, dynamic>;

      Profile profile = Profile(
        id: profileResponse['id'],
        name: profileResponse['name'],
        userName: profileResponse['username'],
        email: profileResponse['email'],
        phoneNumber: profileResponse['phoneNumber'],
        address: profileResponse['address'],
        imageUrl: profileResponse['imageURL'],
      );
      print("SELESAI GET PROFILE");
      return profile;
    } catch (e) {
      rethrow;
    }
  }
}
