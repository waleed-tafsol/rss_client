import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../view_models/settings_view_model.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/app_secondary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/profile_form.dart';

class Settings extends StatelessWidget {
  static const String routeName = '/settings';
  const Settings({super.key});

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
                  SettingsType.password => _buildPasswordView(),
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
        const AppTextField(title: 'Current Password'),
        SizedBox(height: 16.sp),
        const AppTextField(title: 'New Password'),
        SizedBox(height: 16.sp),
        const AppTextField(title: 'Confirm New Password'),
        SizedBox(height: 16.sp),
        Row(
          children: [
            const AppGradientButton(
              title: 'Update Password',
              icon: TablerIcons.check,
            ),
            SizedBox(width: 12.sp),
            const AppSecondaryButton(title: 'Cancel', icon: TablerIcons.x),
          ],
        ),
      ],
    );
  }
}
