import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../resources/app_fonts.dart';
import 'app_gradient_button.dart';
import 'app_network_image.dart';
import 'app_secondary_button.dart';
import 'app_text_field.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          spacing: 24.w,
          children: [
            AppNetworkImage(
              imageUrl: 'https://picsum.photos/400/400',
              width: 120.w,
              height: 120.w,
            ),
            Column(
              spacing: 8.sp,
              children: [
                const AppSecondaryButton(
                  title: 'Upload an Image',
                  icon: TablerIcons.upload,
                ),
                Text(
                  'Allowed jpeg, jpg, png \nMax size of 4.00 MB',
                  style: AppFonts.grey12w400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        Divider(height: 32.sp),
        Text('Basic Details', style: AppFonts.black18w500),
        SizedBox(height: 16.sp),
        Row(
          spacing: 16.w,
          children: const [
            Expanded(child: AppTextField(title: 'Full Name')),
            Expanded(child: AppTextField(title: 'Email')),
          ],
        ),
        SizedBox(height: 16.sp),
        const AppTextField(title: 'Contact Number'),
        SizedBox(height: 16.sp),
        Row(
          spacing: 12.w,
          children: const [
            AppGradientButton(title: 'Save Changes', icon: TablerIcons.check),
            AppSecondaryButton(title: 'Cancel', icon: TablerIcons.x),
          ],
        ),
      ],
    );
  }
}
