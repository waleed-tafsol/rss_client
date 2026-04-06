import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../utils/context_utils.dart';
import '../../utils/enums.dart';
import '../../utils/validators.dart';
import '../resources/app_assets.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/app_gradient_button.dart';
import '../widgets/app_loader.dart';
import '../widgets/app_text_field.dart';
import 'dashboard/overview_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final ValueNotifier<bool> _rememberMe = ValueNotifier<bool>(true);
  final _hidePassword = ValueNotifier(true);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  void _onSignInPressed() {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    ref
        .read(authProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  void _onForgotPasswordSubmitTap() {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    ref
        .read(authProvider.notifier)
        .forgotPassword(email: _emailController.text.trim());
  }

  void _onOtpSubmitTap() {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    ref
        .read(authProvider.notifier)
        .verifyOtp(
          email: _emailController.text.trim(),
          otp: _pinController.text.trim(),
        );
  }

  Future<void> _listener(AuthState? prev, AuthState next) async {
    if (next.user != null) {
      context.go(OverViewScreen.routeName);
    }
    log('AUTH VIEW: ${next.authView}');
  }

  @override
  void dispose() {
    _rememberMe.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _hidePassword.dispose();
    _pinController.dispose();
    _newPasswordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, _listener);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.isLandscape ? 16.w : 20.sp),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.isLandscape ? 64.w : 0,
                  right: context.isLandscape ? 20.w : 0,
                ),
                child: _buildBody(context),
              ),
            ),
            if (context.isLandscape)
              Expanded(child: Image.asset(PngAssets.login, fit: BoxFit.fill)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Consumer(
        builder: (_, ref, _) {
          final authView = ref.watch(authProvider.select((s) => s.authView));
          final child = switch (authView) {
            AuthView.login => _buildLoginView(context),
            AuthView.forgotPassword => _buildForgotPasswordView(),
            AuthView.otp => _buildOtpView(),
            AuthView.resetPassword => _buildResetPasswordView(),
          };
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: child,
          );
        },
      ),
    );
  }

  Column _buildLoginView(BuildContext context) {
    return Column(
      key: const ValueKey(AuthView.login),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: .center,
      children: [
        Text("Welcome Back!", style: AppFonts.black32w600),
        SizedBox(height: 12.sp),
        Padding(
          padding: EdgeInsets.only(right: context.isLandscape ? 100.0.w : 0),
          child: Text(
            "Please enter your credentials to access your account. If you don't have an account, you can sign up below.",
            style: AppFonts.black14w400,
          ),
        ),
        SizedBox(height: 40.sp),
        AppTextField(
          controller: _emailController,
          title: "Email",
          validator: Validators.email,
        ),
        SizedBox(height: 16.sp),
        ValueListenableBuilder(
          valueListenable: _hidePassword,
          builder: (context, hidePassword, _) {
            return AppTextField(
              controller: _passwordController,
              title: "Password",
              validator: Validators.password,
              hide: hidePassword,
              suffix: IconButton(
                onPressed: () => _hidePassword.value = !hidePassword,
                icon: Icon(hidePassword ? TablerIcons.eye : TablerIcons.eyeOff),
              ),
            );
          },
        ),
        SizedBox(height: 16.sp),
        Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _rememberMe,
              builder: (context, value, child) {
                return Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  value: value,
                  onChanged: (bool? newValue) {
                    _rememberMe.value = newValue ?? false;
                  },
                );
              },
            ),
            Text("Remember Me", style: AppFonts.primary14w400),
            const Spacer(),
            TextButton(
              onPressed: () async {
                ref
                    .read(authProvider.notifier)
                    .changeView(AuthView.forgotPassword);
              },
              child: Text(
                "Forgot Password?",
                style: AppFonts.primary14w400.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 32.sp),

        Consumer(
          builder: (_, ref, _) {
            final loading = ref.watch(authProvider.select((s) => s.loading));
            if (loading) {
              return const AppLoader();
            }
            return AppGradientButton(
              title: 'Sign In',
              icon: TablerIcons.arrowRight,
              onTap: _onSignInPressed,
            );
          },
        ),
      ],
    );
  }

  Column _buildForgotPasswordView() {
    return Column(
      key: const ValueKey(AuthView.forgotPassword),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: .center,
      children: [
        IconButton(
          onPressed: () async {
            ref.read(authProvider.notifier).changeView(AuthView.login);
          },
          icon: const Icon(TablerIcons.chevronLeft),
        ),
        SizedBox(height: 32.h),
        AppTextField(
          controller: _emailController,
          title: "Email",
          validator: Validators.email,
        ),
        SizedBox(height: 32.sp),
        Consumer(
          builder: (_, ref, _) {
            final loading = ref.watch(authProvider.select((s) => s.loading));
            if (loading) {
              return const AppLoader();
            }
            return AppGradientButton(
              title: 'Submit',
              icon: Icons.arrow_forward,
              onTap: _onForgotPasswordSubmitTap,
            );
          },
        ),
      ],
    );
  }

  Column _buildOtpView() {
    return Column(
      key: const ValueKey(AuthView.otp),
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      children: [
        IconButton(
          onPressed: () async {
            ref.read(authProvider.notifier).changeView(AuthView.login);
          },
          icon: const Icon(TablerIcons.chevronLeft),
        ),
        SizedBox(height: 32.h),
        Center(
          child: Pinput(
            controller: _pinController,
            length: 4,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pin cannot be empty';
              }
              if (value.length != 4) {
                return 'Pin must be 4 digits';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 32.sp),
        Consumer(
          builder: (_, ref, _) {
            final loading = ref.watch(authProvider.select((s) => s.loading));
            if (loading) {
              return const AppLoader();
            }
            return AppGradientButton(
              title: 'Submit',
              icon: Icons.arrow_forward,
              onTap: _onOtpSubmitTap,
            );
          },
        ),
      ],
    );
  }

  Column _buildResetPasswordView() {
    return Column(
      children: [
        IconButton(
          onPressed: () async {
            ref.read(authProvider.notifier).changeView(AuthView.login);
          },
          icon: const Icon(TablerIcons.chevronLeft),
        ),
        SizedBox(height: 32.h),
        ValueListenableBuilder(
          valueListenable: _hidePassword,
          builder: (context, hidePassword, _) {
            return Column(
              spacing: 16.sp,
              children: [
                AppTextField(
                  controller: _newPasswordController,
                  title: 'New password',
                  validator: Validators.password,
                  hide: hidePassword,
                  suffix: IconButton(
                    onPressed: () => _hidePassword.value = !hidePassword,
                    icon: Icon(
                      hidePassword ? TablerIcons.eye : TablerIcons.eyeOff,
                    ),
                  ),
                ),
                AppTextField(
                  controller: _confirmPassController,
                  title: 'Confirm password',
                  validator: Validators.password,
                  hide: hidePassword,
                  suffix: IconButton(
                    onPressed: () => _hidePassword.value = !hidePassword,
                    icon: Icon(
                      hidePassword ? TablerIcons.eye : TablerIcons.eyeOff,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 32.sp),
        Consumer(
          builder: (_, ref, _) {
            final loading = ref.watch(authProvider.select((s) => s.loading));
            if (loading) {
              return const AppLoader();
            }
            return AppGradientButton(
              title: 'Submit',
              icon: Icons.arrow_forward,
              onTap: _onOtpSubmitTap,
            );
          },
        ),
      ],
    );
  }
}
