import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_app_bar.dart';

class Dashboard extends StatefulWidget {
  final Widget child;

  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      // appBar: !context.isLandscape
      //     ? AppBar(
      //         backgroundColor: Colors.transparent,
      //         scrolledUnderElevation: 0,
      //       )
      //     : null,
      extendBodyBehindAppBar: true,
      drawer: context.isLandscape
          ? const SizedBox.shrink()
          : AppDrawer(controller: _controller),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            context.isLandscape
                ? AppDrawer(controller: _controller)
                : const SizedBox.shrink(),
            Expanded(
              child: Column(
                children: [
                  CustomAppBar(controller: _controller),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.sp),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
