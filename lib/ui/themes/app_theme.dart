import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    listTileTheme: const ListTileThemeData(
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
      horizontalTitleGap: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.sp),
      hintStyle: AppFonts.grey14w400,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightGrey2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightGrey2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightGrey2),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      tilePadding: EdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: const BorderSide(color: AppColors.lightGrey1),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: const BorderSide(color: AppColors.lightGrey1),
      ),
    ),
    menuTheme: MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.white),
        padding: WidgetStatePropertyAll(EdgeInsets.all(8.w)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.r),
          ),
        ),
      ),
    ),
    switchTheme: const SwitchThemeData(
      trackColor: WidgetStatePropertyAll(AppColors.lightGrey2),
      thumbColor: WidgetStatePropertyAll(AppColors.white),
    ),
    cardTheme: CardThemeData(
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.lightGrey2),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.r),
      ),
      backgroundColor: AppColors.primaryLight,
      side: BorderSide.none,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(primaryContainer: AppColors.white),
  );

  static ThemeData get darkTheme => lightTheme;
}
