import '../../domain/entities/app_user.dart';

abstract class AuthRemoteDataSource {
  Future<AppUser?> getCurrentUser();

  Future<AppUser> loginWithEmail({
    required String email,
    required String password,
  });

  Future<AppUser> loginWithGoogle();

  Future<void> logout();
}
