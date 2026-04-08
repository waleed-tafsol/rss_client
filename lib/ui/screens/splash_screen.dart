import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../services/locator.dart';
import '../view_models/auth_view_model.dart';
import 'dashboard/overview_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.addListener(_authListener);
      Future.delayed(const Duration(seconds: 2), () {
        authViewModel.checkAuthentication();
      });
    });
  }

  void _authListener() async {
    if (!mounted) return;
    final token = await locator<StorageService>().getAccessToken();
    if(token != ""){
final authViewModel = context.read<AuthViewModel>();
    authViewModel.getMe().then((value) {
      if (value == true) {
        context.go(OverViewScreen.routeName);
      } else {
        context.go(LoginScreen.routeName);
      }
    });
    }else {
      context.go(LoginScreen.routeName);
    }
    
    // if (authViewModel.user != null) {
    //   context.go(OverViewScreen.routeName);
    // } else if (authViewModel.authView == AuthView.login &&
    //     !authViewModel.loading) {
    //   // We only navigate to login if authentication check is finished and no user found.
    //   // Note: checkAuthentication sets loading=false and notifies listeners.
    //   context.go(LoginScreen.routeName);
    // }
  }

  @override
  void dispose() {
    // Note: Removing listener from a provider in dispose can be tricky if the provider is already disposed.
    // However, since it's a root provider, it's usually safe or we can use a try-catch/mounted check.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
