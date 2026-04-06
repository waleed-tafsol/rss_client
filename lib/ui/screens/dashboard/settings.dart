import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Consumer(
      builder: (_, ref, _) {
        final settingsType = ref.watch(settingsProvider);
        return Column(
          crossAxisAlignment: .start,
          spacing: 20.sp,
          children: [
            Wrap(
              spacing: 12.w,
              children: List.generate(SettingsType.values.length, (index) {
                final type = SettingsType.values[index];
                final bool isSelected = settingsType == type;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) {
                    ref
                        .read(settingsProvider.notifier)
                        .updateSettingsType(type);
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
      crossAxisAlignment: .start,
      spacing: 16.sp,
      children: [
        Text('Update Password', style: AppFonts.black18w500),
        const AppTextField(title: 'Current Password'),
        const AppTextField(title: 'New Password'),
        const AppTextField(title: 'Confirm New Password'),
        Row(
          spacing: 12.sp,
          children: const [
            AppGradientButton(
              title: 'Update Password',
              icon: TablerIcons.check,
            ),
            AppSecondaryButton(title: 'Cancel', icon: TablerIcons.x),
          ],
        ),
      ],
    );
  }
}
