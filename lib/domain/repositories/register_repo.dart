import '../entitites/register.dart';

abstract class RegisterRepository{
  Future<Register> register(String name, String username, String email, String phoneNumber, String address, String password);
}