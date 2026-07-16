import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../providers/auth_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Bay UI a tan pou l afiche avan navigasyon
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    final authState = ref.read(authProvider);

    authState.when(
      data: (user) {
        if (!mounted) return;

        if (user == null) {
          context.go(AppRoutes.login);
        } else {
          context.go(AppRoutes.dashboard);
        }
      },
      loading: () {
        // Rete sou Splash pandan loading
      },
      error: (_, _) {
        if (!mounted) return;
        context.go(AppRoutes.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
