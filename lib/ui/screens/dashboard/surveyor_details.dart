import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_custom_table.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/app_network_image.dart';
import '../../widgets/app_secondary_button.dart';
import '../../widgets/status_chip.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../utils/enums.dart';
import '../../resources/app_colors.dart';
import '../../widgets/status_box.dart';

class SurveyorDetails extends StatelessWidget {
  static const String routeName = '/surveyor-details';
  const SurveyorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      spacing: 20.w,
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: SizedBox(
              width: 250.w,
              child: Column(
                mainAxisSize: .min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: AppNetworkImage(
                      imageUrl: 'https://picsum.photos/400/400',
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Text('Anakin Skywalker', style: AppFonts.black24w600),
                  Text('Since: Sep 12, 2001', style: AppFonts.black14w400),
                  Divider(height: 32.sp),
                  ListTile(
                    minLeadingWidth: 40.w,
                    leading: Icon(TablerIcons.phone, size: 24.sp),
                    title: Text('+ 305 6523 8741', style: AppFonts.black14w400),
                  ),
                  SizedBox(height: 16.sp),
                  ListTile(
                    minLeadingWidth: 40.w,
                    leading: Icon(TablerIcons.mail, size: 24.sp),
                    title: Text(
                      'anakin@yopmail.com',
                      style: AppFonts.black14w400,
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  ListTile(
                    minLeadingWidth: 40.w,
                    leading: Icon(TablerIcons.mapPin, size: 24.sp),
                    title: Text(
                      '456 Elm Avenue, Westview',
                      style: AppFonts.black14w400,
                    ),
                  ),
                  Divider(height: 32.sp),
                  SwitchListTile(
                    value: false,
                    onChanged: (value) {},
                    activeTrackColor: AppColors.green,

                    title: Text('Active', style: AppFonts.black14w400),
                  ),
                  SizedBox(height: 12.sp),
                  const AppSecondaryButton(
                    title: 'Edit',
                    icon: TablerIcons.pencil,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 20.sp,
            children: [
              Row(
                spacing: 12.w,
                children: const [
                  StatusBox(
                    title: 'Inspections Completed',
                    icon: TablerIcons.reportSearch,
                    count: '75',
                  ),
                  StatusBox(
                    title: 'Conversion Rates',
                    icon: TablerIcons.checks,
                    count: '72%',
                  ),
                ],
              ),
              _buildInspectionHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _buildInspectionHistory() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Inspection History', style: AppFonts.black18w500),
                  const Spacer(),
                   Expanded(
                    child: SizedBox(
                      height: 43.sp,
                      child: const CupertinoSearchTextField(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppDropdown<String>(
                      fillColor: AppColors.lightGrey2,
                      builder: (value) =>
                          Text(value, style: AppFonts.black14w400),
                      items: const ['All Projects', 'Completed'],
                      hint: 'All Projects',
                      onChanged: (_) {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  const AppGradientButton(
                    height: 43,
                    title: 'Assign Project',
                    icon: TablerIcons.plus,
                  ),
                ],
              ),
              SizedBox(height: 16.sp),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        spacing: 16.w,
                        children: const [
                          StatusChip(status: InspectionStatus.inProgress),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 16.sp),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.lightGrey1),
                        ),
                        child: Column(
                          spacing: 12.sp,
                          crossAxisAlignment: .stretch,
                          children: [
                            ListTile(
                              visualDensity: .comfortable,
                              dense: true,
                              minLeadingWidth: 48.w,
                              horizontalTitleGap: 12.w,
                              leading: CircleAvatar(
                                radius: 24.w,
                                backgroundColor: AppColors.primaryLight,
                                child: Icon(
                                  TablerIcons.homeSearch,
                                  size: 24.sp,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              title: Text('URPN', style: AppFonts.grey14w400),
                              subtitle: Text(
                                '71045',
                                style: AppFonts.black18w500,
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  TablerIcons.arrowUpRight,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 12.w,
                              runSpacing: 12.w,
                              crossAxisAlignment: .start,
                              children: [
                                _buildTitleColumn(
                                  title: 'Project Name',
                                  subtitle: 'Greenwich',
                                ),
                                _buildTitleColumn(
                                  title: 'Address',
                                  subtitle: '456 Elm Avenue, Westview',
                                ),
                                _buildTitleColumn(
                                  title: 'Date',
                                  subtitle: 'March 10, 2023',
                                ),
                                _buildTitleColumn(
                                  title: 'Client',
                                  subtitle: 'Eren Yeager',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.sp),
                      Row(
                        spacing: 16.w,
                        children: const [
                          StatusChip(status: InspectionStatus.completed),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 16.sp),
                      _buildTable(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildTitleColumn({
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('$title:', style: AppFonts.grey14w400),
          Text(subtitle, style: AppFonts.black14w400),
        ],
      ),
    );
  }

  AppCustomTable _buildTable() {
    return AppCustomTable(
      columns: const ['Project Name', 'URPN', 'Address', 'Client', 'Date', ''],
      rows: List.generate(10, (rIndex) {
        return List.generate(6, (cIndex) {
          return switch (cIndex) {
            0 => Text('Wandsworth', style: AppFonts.black14w400),
            1 => Text('71045', style: AppFonts.black14w400),
            2 => Text('456 Elm Avenue, Westview', style: AppFonts.black14w400),
            3 => Row(
              spacing: 8.w,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: AppNetworkImage(
                    imageUrl: 'https://picsum.photos/400/400',
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                Text('Bob Loblaw', style: AppFonts.black14w400),
              ],
            ),
            4 => Text('April 15, 2023', style: AppFonts.black14w400),
            5 => IconButton(
              onPressed: () {},
              icon: Icon(TablerIcons.dots, size: 24.sp),
            ),
            int() => throw UnimplementedError(),
          };
        });
      }),
      flexValues: [120.w, 80.w, 230.w, 150.w, 120.w, 70.w],
    );
  }
}
