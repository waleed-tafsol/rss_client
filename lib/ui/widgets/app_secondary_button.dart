import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class AppSecondaryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const AppSecondaryButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      mouseCursor: SystemMouseCursors.click,
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 11.sp, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.lightGrey2,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          spacing: 2.w,
          mainAxisAlignment: .center,
          children: [
            Text(title, style: AppFonts.black14w500),
            Icon(icon, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
