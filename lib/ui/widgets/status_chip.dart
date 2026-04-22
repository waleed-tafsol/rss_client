import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/enums.dart';
import '../resources/app_fonts.dart';
import '../../utils/inspection_status.dart';

class StatusChip extends StatelessWidget {
  final Status status;
  final String? title;
  const StatusChip({super.key, required this.status, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Container(
            width: 6.w,
            height: 6.sp,
            decoration: BoxDecoration(
              color: status.fontColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              status.label,
              style: AppFonts.black12w400.copyWith(color: status.fontColor),
              overflow: .ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
