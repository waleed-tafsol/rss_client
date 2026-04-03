import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class AppGradientButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final ListTileControlAffinity controlAffinity;
  final double? height;
  final bool selected;
  final bool collapsed;
  const AppGradientButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.controlAffinity = ListTileControlAffinity.trailing,
    this.height,
    this.selected = true,
    this.collapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      if (!collapsed)
        Text(
          title,
          style: selected ? AppFonts.white14w500 : AppFonts.black14w400,
        ),
      Icon(
        icon,
        size: 24.sp,
        color: selected ? AppColors.white : AppColors.textBlack,
      ),
    ];
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          height: height ?? 43.sp,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primaryDark, AppColors.primary],
                  )
                : null,

            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment:  .center,
            spacing: collapsed ? 0 : 12.w,
            children: controlAffinity == ListTileControlAffinity.trailing
                ? children
                : children.reversed.toList(),
          ),
        ),
      ),
    );
  }
}
