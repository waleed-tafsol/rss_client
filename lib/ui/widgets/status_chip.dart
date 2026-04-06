import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/enums.dart';
import '../resources/app_fonts.dart';
import '../../utils/inspection_status.dart';

class StatusChip extends StatelessWidget {
  final InspectionStatus status;
  final String? title;
  const StatusChip({super.key, required this.status, this.title});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.only(left: 5.w, top: 0, bottom: 0),
      avatarBoxConstraints: BoxConstraints(maxHeight: 6.w, maxWidth: 6.w),
      avatar: Container(
        width: 6.w,
        height: 6.w,
        decoration: BoxDecoration(
          color: status.fontColor,
          shape: BoxShape.circle,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
      label: Text(
        title ?? status.label,
        style: AppFonts.black12w400.copyWith(color: status.fontColor),
      ),
      backgroundColor: status.backgroundColor,
    );
  }
}
