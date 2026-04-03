import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/screens/dashboard/client_creation.dart';
import '../ui/screens/dashboard/client_update.dart';
import '../ui/screens/dashboard/crud.dart';
import '../ui/screens/dashboard/dashboard.dart';
import '../ui/screens/dashboard/overview_screen.dart';
import '../ui/screens/dashboard/project_detail.dart';
import '../ui/screens/dashboard/project_management.dart';
import '../ui/screens/dashboard/property_creation.dart';
import '../ui/screens/dashboard/property_detail.dart';
import '../ui/screens/dashboard/settings.dart';
import '../ui/screens/dashboard/surveryor_update.dart';
import '../ui/screens/dashboard/surveyor_creation.dart';
import '../ui/screens/dashboard/surveyor_details.dart';
import '../ui/screens/dashboard/surveyors_analytics.dart';
import '../ui/screens/dashboard/user_management.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/view_models/app_view_model.dart';
import '../ui/view_models/crud_view_model.dart';
import '../ui/view_models/settings_view_model.dart';
import '../ui/view_models/user_management_view_model.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    redirect: (context, _) {
      final isLoggedIn = context.read<AppViewModel>().isLoggedIn;
      if (!isLoggedIn) {
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
            path: UserManagement.routeName,
            name: UserManagement.routeName,
            builder: (_, _) => ChangeNotifierProvider(
              create: (_) => UserManagementViewModel(),
              child: const UserManagement(),
            ),
            routes: [
              GoRoute(
                path: SurveyorDetails.routeName,
                name: SurveyorDetails.routeName,
                builder: (_, _) => const SurveyorDetails(),
              ),
              GoRoute(
                path: ClientCreation.routeName,
                name: ClientCreation.routeName,
                builder: (_, _) => const ClientCreation(),
              ),
              GoRoute(
                path: SurveryorUpdate.routeName,
                name: SurveryorUpdate.routeName,
                builder: (_, _) => const SurveryorUpdate(),
              ),
              GoRoute(
                path: ClientUpdate.routeName,
                name: ClientUpdate.routeName,
                builder: (_, _) => const ClientUpdate(),
              ),
              GoRoute(
                path: SurveyorCreation.routeName,
                name: SurveyorCreation.routeName,
                builder: (_, _) => const SurveyorCreation(),
              ),
            ],
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
            path: Crud.routeName,
            name: Crud.routeName,
            builder: (_, _) => ChangeNotifierProvider(
              create: (_) => CrudViewModel(),
              child: const Crud(),
            ),
          ),
          GoRoute(
            path: SurveyorsAnalytics.routeName,
            name: SurveyorsAnalytics.routeName,
            builder: (_, _) => const SurveyorsAnalytics(),
          ),
          GoRoute(
            path: Settings.routeName,
            name: Settings.routeName,
            builder: (_, _) => ChangeNotifierProvider(
              create: (_) => SettingsViewModel(),
              child: const Settings(),
            ),
          ),
        ],
      ),
    ],
  );
}
