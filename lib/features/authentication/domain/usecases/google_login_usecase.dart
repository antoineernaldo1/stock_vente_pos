import '../entities/app_user.dart';
import '../repository/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<AppUser> call() {
    return repository.googleLogin();
  }
}
