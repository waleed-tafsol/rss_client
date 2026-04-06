import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/locator.dart';
import '../ui/screens/dashboard/dashboard.dart';
import '../ui/screens/dashboard/overview_screen.dart';
import '../ui/screens/dashboard/project_detail.dart';
import '../ui/screens/dashboard/project_management.dart';
import '../ui/screens/dashboard/property_creation.dart';
import '../ui/screens/dashboard/property_detail.dart';
import '../ui/screens/dashboard/settings.dart';
import '../ui/screens/dashboard/surveyors_analytics.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/splash_screen.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    redirect: (context, state) async {
      final token = await locator<StorageService>().getAccessToken();
      if (token == null) {
        return LoginScreen.routeName;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        name: SplashScreen.routeName,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (_, _) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => Dashboard(child: child),
        routes: [
          GoRoute(
            path: OverViewScreen.routeName,
            name: OverViewScreen.routeName,
            builder: (_, _) => const OverViewScreen(),
          ),
          GoRoute(
            path: ProjectManagement.routeName,
            name: ProjectManagement.routeName,
            builder: (_, _) => const ProjectManagement(),
            routes: [
              GoRoute(
                path: ProjectDetail.routeName,
                name: ProjectDetail.routeName,
                builder: (_, _) => const ProjectDetail(),
                routes: [
                  GoRoute(
                    path: PropertyCreation.routeName,
                    name: PropertyCreation.routeName,
                    builder: (_, _) => const PropertyCreation(),
                  ),
                  GoRoute(
                    path: PropertyDetail.routeName,
                    name: PropertyDetail.routeName,
                    builder: (_, _) => PropertyDetail(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: SurveyorsAnalytics.routeName,
            name: SurveyorsAnalytics.routeName,
            builder: (_, _) => const SurveyorsAnalytics(),
          ),
          GoRoute(
            path: Settings.routeName,
            name: Settings.routeName,
            builder: (_, _) => const Settings(),
          ),
        ],
      ),
    ],
  );
}
