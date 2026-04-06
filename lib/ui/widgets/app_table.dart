import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/enums.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../../utils/context_utils.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../screens/dashboard/client_update.dart';
import '../screens/dashboard/surveryor_update.dart';
import '../screens/dashboard/surveyor_details.dart';
import '../view_models/user_management_view_model.dart';
import 'status_chip.dart';

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
        width = 120.w;
        break;
      case 1:
        width = 150.w;
        break;
      case 2:
        width = 269.w;
        break;
      case 3:
        width = 183.w;
        break;
      case 4:
        width = 130.w;
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
        child = Text(data['project'], style: AppFonts.black14w400);
        break;
      case 1:
        child = Text(data['uprn'].toString(), style: AppFonts.black14w400);

        break;
      case 2:
        child = Text(data['address'], style: AppFonts.black14w400);

        break;
      case 3:
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
            Flexible(child: Text(data['name'], style: AppFonts.black14w500)),
          ],
        );

        break;
      case 4:
        child = Text(data['date'], style: AppFonts.black14w400);
        break;
      case 5:
        child = StatusChip(status: data['status']);
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
            Consumer<UserManagementViewModel>(
              builder: (context, userManagementViewModel, _) {
                final userType = userManagementViewModel.userType;
                return ListTile(
                  onTap: () {
                    if (userType == UserType.surveyors) {
                      context.goNamed(SurveryorUpdate.routeName);
                    } else {
                      context.goNamed(ClientUpdate.routeName);
                    }
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

  static const List<String> _headerLabels = [
    'Project Name',
    'UPRN',
    'Address',
    'Assigned Surveyor',
    'Date',
    'Status',
    '',
  ];

  static const List<Map<String, dynamic>> _dummyData = [
    {
      'project': 'Wandsworth',
      'uprn': '71045',
      'address': '456 Elm Avenue, Westview',
      'name': 'Maeby Funke',
      'date': 'Dec 03, 2023',
      'status': InspectionStatus.inProgress,
    },
    {
      'project': 'Greenwich',
      'uprn': '28944',
      'address': '789 Oak Street, Hillside',
      'name': 'Bob Loblaw',
      'date': 'Jan 27, 2024',
      'status': InspectionStatus.inProgress,
    },
    {
      'project': 'LBHF',
      'uprn': '16021',
      'address': '101 Pine Lane, Valleywood',
      'name': 'Maeby Funke',
      'date': 'Nov 18, 2023',
      'status': InspectionStatus.upcoming,
    },
    {
      'project': 'Guildford',
      'uprn': '46508',
      'address': '222 Maple Drive, Brookside',
      'name': 'George Michael',
      'date': 'Jul 04, 2023',
      'status': InspectionStatus.upcoming,
    },
    {
      'project': 'Oxford',
      'uprn': '73070',
      'address': '333 Cherry Court, Lakeside',
      'name': 'Maeby Funke',
      'date': 'Sep 22, 2023',
      'status': InspectionStatus.upcoming,
    },
    {
      'project': 'Sutton',
      'uprn': '5840',
      'address': '888 Walnut Lane, Desert Ridge',
      'name': 'Bob Loblaw',
      'date': 'Mar 11, 2024',
      'status': InspectionStatus.upcoming,
    },
    {
      'project': 'LBHF',
      'uprn': '71045',
      'address': '777 Spruce Street, Greenfield',
      'name': 'Lindsay Bluth',
      'date': 'Aug 01, 2023',
      'status': InspectionStatus.upcoming,
    },
    {
      'project': 'Wandsworth',
      'uprn': '28944',
      'address': '111 Pine Avenue, Summerfield',
      'name': 'Kitty Sanchez',
      'date': 'Jun 14, 2023',
      'status': InspectionStatus.completed,
    },
    {
      'project': 'Greenwich',
      'uprn': '16021',
      'address': '444 Birch Lane, Riverside',
      'name': 'Tobias Funke',
      'date': 'Oct 08, 2023',
      'status': InspectionStatus.completed,
    },
    {
      'project': 'LBHF',
      'uprn': '46508',
      'address': '555 Cedar Road, Mountainview',
      'name': 'Lindsay Bluth',
      'date': 'Feb 29, 2024',
      'status': InspectionStatus.completed,
    },
    {
      'project': 'Guildford',
      'uprn': '73070',
      'address': '555 Cedar Road, Mountainview',
      'name': 'Lindsay Bluth',
      'date': 'Feb 29, 2024',
      'status': InspectionStatus.completed,
    },
    {
      'project': 'Sutton',
      'uprn': '5840',
      'address': '999 Willow Way, Oakville',
      'name': 'George Michael',
      'date': 'Apr 15, 2024',
      'status': InspectionStatus.inProgress,
    },
    {
      'project': 'Oxford',
      'uprn': '71045',
      'address': '123 Birch Street, Maplewood',
      'name': 'Kitty Sanchez',
      'date': 'May 20, 2024',
      'status': InspectionStatus.upcoming,
    },
  ];
}
