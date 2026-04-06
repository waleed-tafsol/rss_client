import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rss_client.dart';
import 'services/locator.dart';
import 'ui/resources/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFonts();
  await initializeServices();
  usePathUrlStrategy();
  runApp(const ProviderScope(child: RssClient()));
}

Future<void> _initializeFonts() async {
  try {
    await GoogleFonts.pendingFonts([GoogleFonts.poppinsTextTheme()]);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0.sp
    ..errorWidget = Icon(Icons.error, color: Colors.red, size: 45.0.sp)
    ..radius = 10.0.r
    ..progressColor = AppColors.primary
    ..backgroundColor = Colors.white
    ..boxShadow = [
      BoxShadow(color: Colors.grey.withValues(alpha: 0.5), blurRadius: 10),
    ]
    ..indicatorColor = AppColors.primary
    ..textColor = AppColors.primary
    ..textStyle = TextStyle(
      color: AppColors.primary,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    )
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..userInteractions = false
    ..dismissOnTap = false;
}
