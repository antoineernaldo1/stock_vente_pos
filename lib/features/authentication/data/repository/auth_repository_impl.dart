import '../../domain/entities/app_user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AppUser?> currentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<AppUser> login({required String email, required String password}) {
    return remoteDataSource.loginWithEmail(email: email, password: password);
  }

  @override
  Future<AppUser> googleLogin() {
    return remoteDataSource.loginWithGoogle();
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}
