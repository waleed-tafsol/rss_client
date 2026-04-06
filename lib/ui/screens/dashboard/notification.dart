import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_gradient_button.dart';

class Notifications extends StatelessWidget {
  static const String routeName = '/notification';
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 43.w,
              width: 260.w,
              child: CupertinoSearchTextField(
                backgroundColor: AppColors.lightGrey2,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            const Spacer(),
            Container(
              height: 43.w,
              padding: .symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.lightGrey2,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text("Date", style: AppFonts.black14w500),
                  SizedBox(width: 4.w),
                  Icon(TablerIcons.chevronDown, size: 16.sp),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            const AppGradientButton(
              title: "Mark all as Read",
              icon: TablerIcons.checks,
            ),
          ],
        ),
        SizedBox(height: 20.sp),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 2.sp),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.sp,
                ),
                color: i % 3 == 0 || i % 4 == 0 ? AppColors.primaryLight : null,
                child: Text(
                  'Crane #${i + 1} maintenance completed',
                  style: AppFonts.black14w400,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
