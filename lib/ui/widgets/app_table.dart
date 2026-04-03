import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../utils/context_utils.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../screens/dashboard/surveyor_details.dart';

class AppTable extends StatelessWidget {
  const AppTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGrey1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: TableView.builder(
          columnCount: 7,
          rowCount: _dummyData.length + 1,
          columnBuilder: (index) => _buildColumnSpan(context, index),
          rowBuilder: _buildRowSpan,
          cellBuilder: _buildCell,
        ),
      ),
    );
  }

  TableSpan _buildColumnSpan(BuildContext context, int index) {
    final double width;
    switch (index) {
      case 0:
        width = 180.w;
        break;
      case 1:
        width = 180.w;
        break;
      case 2:
        width = 170.w;
        break;
      case 3:
        width = 180.w;
        break;
      case 4:
        width = 140.w;
        break;
      case 5:
        width = 120.w;
        break;
      case 6:
        width = 100.w;
      default:
        width = 150.w;
    }
    if (context.isMobile) {
      return TableSpan(extent: FixedSpanExtent(width));
    }
    return TableSpan(extent: FractionalSpanExtent(width / 1068.w));
  }

  TableSpan _buildRowSpan(int index) {
    return TableSpan(
      extent: FixedTableSpanExtent(50.sp),
      backgroundDecoration: TableSpanDecoration(
        border: index == 0
            ? const SpanBorder(
                trailing: BorderSide(color: AppColors.lightGrey1),
              )
            : null,
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    if (vicinity.row == 0) {
      return TableViewCell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _headerLabels[vicinity.column],
              style: AppFonts.grey14w400,
            ),
          ),
        ),
      );
    }

    final data = _dummyData[vicinity.row - 1];
    Widget child;

    switch (vicinity.column) {
      case 0:
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14.r,
              backgroundColor: AppColors.lightGrey1,
              backgroundImage: const CachedNetworkImageProvider(
                'https://picsum.photos/400/400',
              ),
            ),
            SizedBox(width: 12.w),
            Text(data['name'], style: AppFonts.black14w500),
          ],
        );
        break;
      case 1:
        child = Text(data['email'], style: AppFonts.black14w400);
        break;
      case 2:
        child = Text(
          data['inspections'].toString(),
          style: AppFonts.black14w400,
        );
        break;
      case 3:
        child = Text(data['project'], style: AppFonts.black14w400);
        break;
      case 4:
        child = Text(data['date'], style: AppFonts.black14w400);
        break;
      case 5:
        child = _buildStatus(data['status']);
        break;
      case 6:
        final controller = MenuController();
        child = MenuAnchor(
          controller: controller,
          consumeOutsideTap: true,
          menuChildren: [
            ListTile(
              onTap: () {
                controller.close();
                context.goNamed(SurveyorDetails.routeName);
              },
              leading: Icon(TablerIcons.eye, size: 24.sp),
              horizontalTitleGap: 16.w,
              minLeadingWidth: 24.sp,
              title: Text('View Details', style: AppFonts.grey14w400),
              contentPadding: EdgeInsets.zero,
            ),
            Consumer(
              builder: (context, ref, _) {
                return ListTile(
                  onTap: () {
                    // if (userType == UserType.surveyor) {
                    //   context.goNamed(SurveryorUpdate.routeName);
                    // } else {
                    //   context.goNamed(ClientUpdate.routeName);
                    // }
                    controller.close();
                  },
                  leading: Icon(TablerIcons.pencil, size: 24.sp),
                  horizontalTitleGap: 16.w,
                  minLeadingWidth: 24.sp,
                  title: Text('Edit', style: AppFonts.grey14w400),
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
            ListTile(
              onTap: () {
                controller.close();
              },
              leading: Icon(TablerIcons.ban, size: 24.sp, color: AppColors.red),
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
            icon: Icon(TablerIcons.dots, size: 24.sp),
          ),
        );
      default:
        child = const SizedBox.shrink();
    }

    return TableViewCell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Align(alignment: Alignment.centerLeft, child: child),
      ),
    );
  }

  Widget _buildStatus(String status) {
    final bool isActive = status == 'Active';
    final Color color = isActive ? const Color(0xFF4CAF50) : AppColors.grey;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          status,
          style: AppFonts.black14w600.copyWith(color: color, fontSize: 12.sp),
        ),
      ],
    );
  }

  static const List<String> _headerLabels = [
    'Name',
    'Email',
    'Inspections Completed',
    'Assigned Project',
    'Creation Date',
    'Status',
    '',
  ];

  static const List<Map<String, dynamic>> _dummyData = [
    {
      'name': 'Maeby Funke',
      'email': 'maeby@gmail.com',
      'inspections': 75,
      'project': 'Wandsworth',
      'date': 'Dec 03, 2022',
      'status': 'Active',
    },
    {
      'name': 'Bob Loblaw',
      'email': 'bob@gmail.com',
      'inspections': 12,
      'project': 'Greenwich',
      'date': 'Jan 21, 2023',
      'status': 'Active',
    },
    {
      'name': 'Maeby Funke',
      'email': 'maeby@gmail.com',
      'inspections': 63,
      'project': 'LBHF',
      'date': 'Jul 16, 2022',
      'status': 'Active',
    },
    {
      'name': 'George Michael',
      'email': 'george@gmail.com',
      'inspections': 31,
      'project': 'Guildford',
      'date': 'Aug 08, 2023',
      'status': 'Active',
    },
    {
      'name': 'Maeby Funke',
      'email': 'maeby@gmail.com',
      'inspections': 31,
      'project': '--',
      'date': 'Nov 29, 2022',
      'status': 'Active',
    },
    {
      'name': 'Michael Bluth',
      'email': 'michael@gmail.com',
      'inspections': 12,
      'project': 'Guildford',
      'date': 'Feb 14, 2023',
      'status': 'Active',
    },
    {
      'name': 'Lucille Bluth',
      'email': 'lucille@gmail.com',
      'inspections': 44,
      'project': 'Sutton',
      'date': 'Sep 01, 2022',
      'status': 'Inactive',
    },
    {
      'name': 'Tobias Funke',
      'email': 'tobias@gmail.com',
      'inspections': 23,
      'project': '--',
      'date': 'Oct 19, 2023',
      'status': 'Active',
    },
    {
      'name': 'Buster Bluth',
      'email': 'buster@gmail.com',
      'inspections': 64,
      'project': 'Greenwich',
      'date': 'Mar 07, 2023',
      'status': 'Inactive',
    },
    {
      'name': 'Lindsay Bluth',
      'email': 'lindsay@gmail.com',
      'inspections': 12,
      'project': 'Greenwich',
      'date': 'Jun 12, 2022',
      'status': 'Active',
    },
    {
      'name': 'Gob Bluth',
      'email': 'gob@gmail.com',
      'inspections': 15,
      'project': '--',
      'date': 'Apr 26, 2023',
      'status': 'Active',
    },
  ];
}
