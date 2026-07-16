import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stock_vente_pos/app/dependency_injection.dart';
import '../../domain/entities/app_user.dart';

final authProvider =
    StateNotifierProvider<AuthController, AsyncValue<AppUser?>>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AsyncValue<AppUser?>> {
  AuthController() : super(const AsyncValue.loading()) {
    checkUser();
  }

  final _currentUser = DependencyInjection.currentUserUseCase();
  final _login = DependencyInjection.loginUseCase();
  final _googleLogin = DependencyInjection.googleLoginUseCase();
  final _logout = DependencyInjection.logoutUseCase();

  Future<void> checkUser() async {
    final user = await _currentUser();
    state = AsyncValue.data(user);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final user = await _login(email: email, password: password);
    state = AsyncValue.data(user);
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();

    final user = await _googleLogin();
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    await _logout();
    state = const AsyncValue.data(null);
  }
}