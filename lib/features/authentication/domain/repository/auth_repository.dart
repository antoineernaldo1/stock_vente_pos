import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> currentUser();

  Future<AppUser> login({required String email, required String password});

  Future<AppUser> googleLogin();

  Future<void> logout();
}
