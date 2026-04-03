import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final Widget Function(T) builder;
  final ValueSetter<T?>? onChanged;
  final String? Function(T?)? validator;
  final Color? fillColor;

  const AppDropdown({
    super.key,
    this.value,
    required this.hint,
    required this.items,
    required this.builder,
    this.onChanged,
    this.validator,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.sp,
      child: DropdownButtonFormField2<T>(
        style: AppFonts.black14w400,
        value: value,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxWidth: 200.w, minWidth: 100.w),
          hintText: hint,
          hintStyle: AppFonts.black14w400,
          filled: true,
          fillColor: fillColor ??  Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightGrey2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightGrey2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightGrey2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(
            // horizontal: 16.w,
            vertical: 11.sp,
          ),
        ),
        isExpanded: true,
        hint: Text(hint),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(value: item, child: builder(item)),
            )
            .toList(),
        onChanged: onChanged,
        validator: validator,
        buttonStyleData: ButtonStyleData(
          // height: 20.sp,
          padding: EdgeInsets.only(right: 10.w),
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            CupertinoIcons.chevron_down,
            color: AppColors.textBlack,
          ),
          iconSize: 16.sp,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.sp,
          offset: const Offset(0, -10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
      ),
    );
  }
}
