import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_assets.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

//ye name walled bhai aur tauqeer bhai ne rakha hai, isliye rakha hai
class StatusBox extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  const StatusBox({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.sp,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(PngAssets.purpleShadow),

          alignment: Alignment.topRight,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: .start,

        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryDark, size: 24.sp),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppFonts.black14w400),
                SizedBox(height: 4.sp),
                Text(count, style: AppFonts.black18w600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
