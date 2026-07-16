import '../entities/app_user.dart';
import '../repository/auth_repository.dart';

class CurrentUserUseCase {
  final AuthRepository repository;

  CurrentUserUseCase(this.repository);

  Future<AppUser?> call() {
    return repository.currentUser();
  }
}
