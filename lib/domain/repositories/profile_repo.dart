import '../entitites/profile.dart';

abstract class ProfileRepository {
  Future<Profile> profile();
}