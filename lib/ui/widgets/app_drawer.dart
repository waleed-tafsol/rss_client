import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../models/ui/rail_item.dart';
import '../resources/app_assets.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../screens/dashboard/overview_screen.dart';
import '../screens/dashboard/properties.dart';
import '../screens/dashboard/settings.dart';
import 'app_gradient_button.dart';

class AppDrawer extends StatefulWidget {
  final SidebarXController controller;
  const AppDrawer({super.key, required this.controller});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).routerDelegate.addListener(_listener);
      _listener();
    });
  }

  final _items = [
    const RailItem(
      icon: TablerIcons.layoutGrid,
      label: 'Overview',
      routeName: OverViewScreen.routeName,
    ),
    const RailItem(
      icon: TablerIcons.mapPin,
      label: 'Properties',
      routeName: Properties.routeName,
    ),
  ];

  SidebarXTheme getTheme({required bool isExpanded}) {
    return SidebarXTheme(
      width: isExpanded ? 250.w : 90.w,
      textStyle: AppFonts.black14w400,
      selectedTextStyle: AppFonts.white14w500,
      hoverTextStyle: AppFonts.black14w400,
      selectedItemPadding: EdgeInsets.all(12.w),
      selectedIconTheme: IconThemeData(color: AppColors.white, size: 24.sp),
      iconTheme: IconThemeData(color: AppColors.textBlack, size: 24.sp),
      hoverIconTheme: IconThemeData(color: AppColors.textBlack, size: 24.sp),
      selectedItemDecoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: kElevationToShadow[1],
      ),
      itemTextPadding: EdgeInsets.only(left: 12.w),
      selectedItemTextPadding: EdgeInsets.only(left: 12.w),
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.only(right: 20.w),
    );
  }

  void _listener() {
    if (!mounted) {
      return;
    }
    final routeName = GoRouter.of(context).state.name;
    int index = _items.indexWhere((item) => item.routeName == routeName);
    if (index == -1 && routeName == Settings.routeName) {
      index = _items.length;
    }
    if (index != -1 && index != widget.controller.selectedIndex) {
      widget.controller.selectIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: false,
      controller: widget.controller,
      theme: getTheme(isExpanded: false),
      extendedTheme: getTheme(isExpanded: true),
      headerBuilder: (_, value) {
        return SvgPicture.asset(
          value ? SvgAssets.textLogo : SvgAssets.logo,
          height: 50.sp,
          width: value ? null : 50.sp,
        );
      },
      footerBuilder: (context, value) {
        return AppGradientButton(
          title: 'Settings',
          icon: TablerIcons.settings,
          controlAffinity: ListTileControlAffinity.leading,
          height: 48.sp,
          selected: widget.controller.selectedIndex == _items.length,
          onTap: () => context.go(Settings.routeName),
          collapsed: !value,
        );
      },
      headerDivider: Divider(height: 32.sp),
      footerDivider: Divider(height: 32.sp),
      items: _items
          .map(
            (item) => SidebarXItem(
              label: item.label,
              icon: item.icon,
              onTap: () {
                log('Tapped on ${item.label}, route: ${item.routeName}');
                widget.controller.selectIndex(_items.indexOf(item));
                context.goNamed(item.routeName);
              },
            ),
          )
          .toList(),
    );
  }
}
