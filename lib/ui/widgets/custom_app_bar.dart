import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../utils/context_utils.dart';
import '../../utils/string_utils.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../screens/dashboard/notification.dart';
import '../screens/login_screen.dart';
import '../view_models/app_view_model.dart';
import '../view_models/auth_view_model.dart';
import 'app_network_image.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SidebarXController controller;

  const CustomAppBar({super.key, required this.controller});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 70.sp);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _notificationMenuController = MenuController();
  final _appMenuController = MenuController();

  void _onNotificationTap() {
    if (_notificationMenuController.isOpen) {
      _notificationMenuController.close();
    } else {
      _notificationMenuController.open();
    }
  }

  void _onAvatarTap() {
    if (_appMenuController.isOpen) {
      _appMenuController.close();
    } else {
      _appMenuController.open();
    }
  }

  void _onLogoutPressed() {
    context.read<AuthViewModel>().logout();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   await getUser();
      context.read<AuthViewModel>().addListener(_authListener);
    });
  }

  void _authListener() {
    final authViewModel = context.read<AuthViewModel>();
    if (authViewModel.user == null) {
      context.read<AppViewModel>().setIsLoggedIn(false);
      context.go(LoginScreen.routeName);
    }
  }

  // Future<void> getUser() async {
  //   userData = await locator<StorageService>().getUser();
  //   log("USER: ${userData?.name}");
  // }

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).state.uri.pathSegments.length > 1;
    log('NAME: ${GoRouter.of(context).state.uri}');
    return SizedBox(
      height: 70.sp,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (canPop) {
                context.pop();
              } else {
                if (context.isLandscape) {
                  widget.controller.toggleExtended();
                } else {
                  Scaffold.of(context).openDrawer();
                }
              }
            },
            icon: Icon(
              canPop
                  ? TablerIcons.arrowLeft
                  : context.isLandscape
                  ? TablerIcons.layoutSidebar
                  : TablerIcons.menu2,
            ),
            visualDensity: VisualDensity.compact,
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
            ),
          ),
          SizedBox(height: 30.sp, child: const VerticalDivider()),
          Center(child: Text(context.displayPath, style: AppFonts.black18w600)),
          const Spacer(),
          MenuAnchor(
            controller: _notificationMenuController,
            alignmentOffset: Offset(-400.w, 1),
            style: MenuStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(16.sp)),
            ),
            menuChildren: [_buildNotificationsView()],
            child: CircleAvatar(
              foregroundColor: AppColors.textBlack,
              radius: 20.r,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _onNotificationTap,
                icon: Icon(TablerIcons.bell, size: 24.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          if (!context.isMobile) _buildAvatar(context),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return MenuAnchor(
      controller: _appMenuController,
      alignmentOffset: const Offset(0, 10),
      menuChildren: [
        ListTile(
          onTap: _onLogoutPressed,
          minLeadingWidth: 40.w,
          title: Text('Logout', style: AppFonts.red14w400),
          leading: Icon(TablerIcons.logout, color: AppColors.red, size: 24.sp),
        ),
      ],
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: _onAvatarTap,
          child: Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4.w),
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(30.r),
                    child: AppNetworkImage(
                      width: 32.w,
                      imageUrl: authViewModel.user?.profile?.profileImage ?? "",
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authViewModel.user?.name?.capitalize ?? 'N/A',
                        style: AppFonts.black14w500,
                      ),
                      Text('Client', style: AppFonts.grey12w400),
                    ],
                  ),

                  SizedBox(width: 12.w),
                  Icon(TablerIcons.chevronDown, size: 24.sp),
                  SizedBox(width: 12.w),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsView() {
    return SizedBox(
      width: 400.w,
      height: 400.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Notifications', style: AppFonts.black18w600),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.go(Notifications.routeName);
                },
                child: Row(
                  children: [
                    Text('View All', style: AppFonts.black14w400),
                    Icon(TablerIcons.arrowUpRight, size: 24.sp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 2.sp),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.sp,
                  ),
                  color: i % 3 == 0 || i % 4 == 0
                      ? AppColors.primaryLight
                      : null,
                  child: Text(
                    'Crane #${i + 1} maintenance completed',
                    style: AppFonts.black14w400,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
