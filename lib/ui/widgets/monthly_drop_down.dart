import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class ProgressDropdown extends StatelessWidget {
  const ProgressDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        icon: Padding(
          padding: EdgeInsets.only(left: 8.w, top: 3.sp),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18.sp,
            color: AppColors.textBlack,
          ),
        ),
        isDense: true,
        style: AppFonts.black14w500,
        items: [
          'Monthly',
          'Weekly',
          'Yearly',
        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
