import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../utils/enums.dart';
import '../../utils/inspection_status.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../screens/dashboard/project_detail.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';


class ProjectManagementCard extends StatelessWidget {
  final String location;
  final int propertyCount;
  final String lastUpdated;
  final InspectionStatus status;
  const ProjectManagementCard({
    super.key,
    required this.location,
    required this.propertyCount,
    required this.lastUpdated,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final controller = MenuController();
    return GestureDetector(
      onTap: () {
        context.goNamed(ProjectDetail.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.lightGrey1),
        ),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    TablerIcons.mapPin,
                    color: AppColors.primaryDark,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: status.fontColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          status.name,
                          style: AppFonts.black14w600.copyWith(
                            color: status.fontColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.sp),
                  child: MenuAnchor(
                    controller: controller, // MenuController used here
                    menuChildren: [
                      ListTile(
                        onTap: () {
                          context.goNamed(ProjectDetail.routeName);
                          controller.close();
                        },
                        leading: Icon(TablerIcons.eye, size: 24.sp),
                        horizontalTitleGap: 16.w,
                        minLeadingWidth: 24.sp,
                        title: Text('View Details', style: AppFonts.grey14w400),
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(TablerIcons.pencil, size: 24.sp),
                        horizontalTitleGap: 16.w,
                        minLeadingWidth: 24.sp,
                        title: Text('Edit', style: AppFonts.grey14w400),
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          TablerIcons.ban,
                          size: 24.sp,
                          color: AppColors.red,
                        ),
                        horizontalTitleGap: 16.w,
                        minLeadingWidth: 24.sp,
                        title: Text('Disable', style: AppFonts.grey14w400),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                    child: IconButton(
                      onPressed: () {
                        if (!controller.isOpen) {
                          controller.open();
                        } else {
                          controller.close();
                        }
                      },
                      icon: const Icon(Icons.more_horiz),
                      color: AppColors.lightGrey3,
                      iconSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.sp),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No of Properties:', style: AppFonts.grey14w400),
                      SizedBox(height: 4.sp),
                      Text(
                        '$propertyCount Properties',
                        style: AppFonts.black14w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Updated:', style: AppFonts.grey14w400),
                      SizedBox(height: 4.sp),
                      Text(lastUpdated, style: AppFonts.black14w400),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
