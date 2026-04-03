import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view_models/auth_view_model.dart';
import 'dashboard/overview_screen.dart';
import 'login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        ref.read(authProvider.notifier).checkAuthentication();
      });
    });
  }

  void _listener(AuthState? prev, AuthState next) {
    if (next.user != null) {
      context.go(OverViewScreen.routeName);
    } else {
      context.go(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, _listener);
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
