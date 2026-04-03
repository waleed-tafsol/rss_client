import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../utils/context_utils.dart';
import '../resources/app_assets.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../view_models/app_view_model.dart';
import '../widgets/app_gradient_button.dart';
import '../widgets/app_text_field.dart';
import 'dashboard/overview_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _rememberMe = ValueNotifier<bool>(true);
  final _forgotPassword = ValueNotifier(false);

  @override
  void dispose() {
    _rememberMe.dispose();
    _forgotPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return ValueListenableBuilder(
      valueListenable: _forgotPassword,
      builder: (context, isForgotPassword, _) {
        if (isForgotPassword) {
          return _buildForgotPasswordView();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: .center,
          children: [
            Text("Welcome Back!", style: AppFonts.black32w600),
            SizedBox(height: 12.sp),
            Padding(
              padding: EdgeInsets.only(
                right: context.isLandscape ? 100.0.w : 0,
              ),
              child: Text(
                "Please enter your credentials to access your account. If you don't have an account, you can sign up below.",
                style: AppFonts.black14w400,
              ),
            ),
            SizedBox(height: 40.sp),
            const AppTextField(title: "Email"),
            SizedBox(height: 16.sp),
            const AppTextField(title: "Password"),
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
                  onPressed: () {
                    _forgotPassword.value = true;
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
            AppGradientButton(
              title: 'Sign In',
              icon: TablerIcons.arrowRight,
              onTap: () {
                context.read<AppViewModel>().setIsLoggedIn(true);
                context.goNamed(OverViewScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildForgotPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: .center,
      children: [
        IconButton(
          onPressed: () => _forgotPassword.value = false,
          icon: const Icon(TablerIcons.chevronLeft),
        ),
        SizedBox(height: 32.h),
        const AppTextField(title: "Email"),
        SizedBox(height: 32.sp),
        AppGradientButton(
          title: 'Submit',
          icon: Icons.arrow_forward,
          onTap: () {},
        ),
      ],
    );
  }
}
