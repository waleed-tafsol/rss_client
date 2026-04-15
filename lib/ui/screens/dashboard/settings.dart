import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/validators.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../view_models/app_view_model.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/settings_view_model.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/app_secondary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/profile_form.dart';
import '../login_screen.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/settings';
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _hidecurrentPassword = ValueNotifier(true);
  final _hideConfrimPassword = ValueNotifier(true);
  final _hideNewPassword = ValueNotifier(true);

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _hidecurrentPassword.dispose();
    _hideConfrimPassword.dispose();
    _hideNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (_, viewModel, __) {
        final settingsType = viewModel.settingsType;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12.w,
              children: List.generate(SettingsType.values.length, (index) {
                final type = SettingsType.values[index];
                final bool isSelected = settingsType == type;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) {
                    viewModel.updateSettingsType(type);
                  },
                  showCheckmark: false,
                  backgroundColor: isSelected ? null : AppColors.white,
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryLight
                        : AppColors.lightGrey1,
                  ),
                  label: Text(
                    type.name.capitalize,
                    style: isSelected
                        ? AppFonts.primaryDark16w500
                        : AppFonts.black16w600,
                  ),
                );
              }),
            ),
            SizedBox(height: 20.sp),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: switch (settingsType) {
                  SettingsType.profile => const ProfileForm(),
                  SettingsType.password => Form(
                    key: _formKey,
                    child: _buildPasswordView(),
                  ),
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Update Password', style: AppFonts.black18w500),
        SizedBox(height: 16.sp),
        ValueListenableBuilder(
          valueListenable: _hidecurrentPassword,
          builder: (context, hidePassword, _) {
            return AppTextField(
              controller: currentPasswordController,
              title: 'Current Password',
              validator: Validators.password,
              hide: hidePassword,
              suffix: IconButton(
                onPressed: () => _hidecurrentPassword.value = !hidePassword,
                icon: Icon(hidePassword ? TablerIcons.eye : TablerIcons.eyeOff),
              ),
            );
          },
        ),
        SizedBox(height: 16.sp),
        ValueListenableBuilder(
          valueListenable: _hideNewPassword,
          builder: (context, hidePassword, _) {
            return AppTextField(
              controller: newPasswordController,
              title: 'New Password',
              validator: Validators.password,
              hide: hidePassword,
              suffix: IconButton(
                onPressed: () => _hideNewPassword.value = !hidePassword,
                icon: Icon(hidePassword ? TablerIcons.eye : TablerIcons.eyeOff),
              ),
            );
          },
        ),
        SizedBox(height: 16.sp),
        ValueListenableBuilder(
          valueListenable: _hideConfrimPassword,
          builder: (context, hidePassword, _) {
            return AppTextField(
              controller: confirmPasswordController,
              title: 'Confirm New Password',
              suffix: IconButton(
                onPressed: () => _hideConfrimPassword.value = !hidePassword,
                icon: Icon(hidePassword ? TablerIcons.eye : TablerIcons.eyeOff),
              ),
              validator: (password) {
                final result = Validators.password(password);
                if (result != null) {
                  return result;
                }
                if (password != newPasswordController.text.trim()) {
                  return 'Passwords don\'t match!';
                }
                return null;
              },
            );
          },
        ),
        SizedBox(height: 16.sp),
        Row(
          children: [
            Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                if (authVM.loading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const AppLoader(),
                  );
                }
                return AppGradientButton(
                  title: 'Update Password',
                  icon: TablerIcons.check,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authVM
                          .updateProfile(
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                            confirmPassword: confirmPasswordController.text,
                          )
                          .then((value) async {
                            if (value == true) {
                              await context.read<AuthViewModel>().logout().then(
                                (value) {
                                  if (authVM.user == null) {
                                    context.read<AppViewModel>().setIsLoggedIn(
                                      false,
                                    );
                                    context.go(LoginScreen.routeName);
                                  }
                                },
                              );
                            }
                          });
                    }
                  },
                );
              },
            ),
            SizedBox(width: 12.sp),
            AppSecondaryButton(
              title: 'Cancel',
              icon: TablerIcons.x,
              onTap: () {
                currentPasswordController.clear();
                newPasswordController.clear();
                confirmPasswordController.clear();
              },
            ),
          ],
        ),
      ],
    );
  }
}
