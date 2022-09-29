import '../entitites/user.dart';

abstract class UserRepository {
  Future<User> login(String username, String password);
}