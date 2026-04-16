import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'rss_client.dart';
import 'services/locator.dart';
import 'ui/resources/app_colors.dart';
import 'ui/view_models/app_view_model.dart';
import 'ui/view_models/auth_view_model.dart';
import 'ui/view_models/settings_view_model.dart';
import 'ui/view_models/theme_view_model.dart';
import 'ui/view_models/project_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFonts();
  await initializeServices();
  // usePathUrlStrategy(); // If you need this, ensure it's imported correctly
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()..init()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
      ],
      child: const RssClient(),
    ),
  );
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
