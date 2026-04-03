import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppFonts {
  AppFonts._();
  static TextStyle get _base => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
    height: 0,
  );

  static TextStyle get black12w600 =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp);
  static TextStyle get black12w500 =>
      _base.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp);
  static TextStyle get black12w400 =>
      _base.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp);

  static TextStyle get black16w600 =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp);
  static TextStyle get black16w500 =>
      _base.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp);

  static TextStyle get black22w600 =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: 22.sp);

  static TextStyle get black14w500 =>
      _base.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp);
  static TextStyle get black24w600 =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: 24.sp);
  static TextStyle get black32w600 =>
      _base.copyWith(fontWeight: FontWeight.w600, fontSize: 32.sp);

  static TextStyle get black14w600 =>
      black14w500.copyWith(fontWeight: FontWeight.w600);

  static TextStyle get black14w400 =>
      _base.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp);

  static TextStyle get black18w600 => black16w600.copyWith(fontSize: 18.sp);
  static TextStyle get black18w500 =>
      _base.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp);

  static TextStyle get white14w500 => _base.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle get grey12w400 => _base.copyWith(
    color: AppColors.grey,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get grey10w400 => _base.copyWith(
    color: AppColors.grey,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get grey14w400 =>
      grey12w400.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400);

  static TextStyle get white14w400 => _base.copyWith(
    height: 0,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
  static TextStyle get white14w600 => _base.copyWith(
    color: AppColors.white,
    height: 0,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static TextStyle get white18w600 => _base.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  static TextStyle get primaryDark16w500 => black16w600.copyWith(
    color: AppColors.primaryDark,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get primary14w400 => black14w600.copyWith(
    color: AppColors.primaryDark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get primaryDark14w500 =>
      primaryDark16w500.copyWith(fontSize: 14.sp);
  static TextStyle get red14w400 => black14w400.copyWith(color: AppColors.red);

  static TextStyle get green14w400 =>
      red14w400.copyWith(color: AppColors.green);

  static TextStyle get blue14w400 =>
      green14w400.copyWith(color: AppColors.blue);
}
