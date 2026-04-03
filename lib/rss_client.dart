import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'l10n/app_localizations.dart';
import 'main.dart';
import 'routes/app_routes.dart';
import 'ui/resources/design_size.dart';
import 'ui/themes/app_theme.dart';
import 'utils/context_utils.dart';

class RssClient extends StatelessWidget {
  const RssClient({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getDesignSize(context),
      ensureScreenSize: true,
      enableScaleWH: () => true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        configLoading();
        return MaterialApp.router(
          title: context.localization.appName,
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          builder: EasyLoading.init(),
          routerConfig: AppRoutes.router,
        );
      },
    );
  }
}
