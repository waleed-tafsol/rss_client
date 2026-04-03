import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../../utils/context_utils.dart';
import '../../utils/enums.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'status_chip.dart';

class OverViewTable extends StatelessWidget {
  const OverViewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        width = 140.w;
        break;
      case 1:
        width = 175.w;
        break;
      case 2:
        width = 254.w;
        break;
      case 3:
        width = 123.w;
        break;
      case 4:
        width = 160.w;
        break;
      case 5:
        width = 120.w;
        break;
      case 6:
        width = 70.w;
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
      extent: FixedTableSpanExtent(43.sp),
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
        child = Text(data['projectName'], style: AppFonts.black14w500);
        break;

      case 1:
        child = Text(data['uprn'], style: AppFonts.black14w400);
        break;

      case 2:
        child = Text(data['address'], style: AppFonts.black14w400);
        break;

      case 3:
        child = Text(data['date'], style: AppFonts.black14w400);
        break;
      case 4:
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14.r,
              backgroundColor: AppColors.lightGrey1,
              backgroundImage: NetworkImage(data['surveyorImage']),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: Text(data['surveyorName'], style: AppFonts.black14w500),
            ),
          ],
        );
        break;
      case 5:
        child = StatusChip(status: data['status']);
        break;
      case 6:
        final controller = MenuController();
        child = MenuAnchor(
          controller: controller,

          menuChildren: [
            ListTile(
              onTap: () {},
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

  // Widget _buildStatus(InspectionStatus status) {
  //   return Chip(
  //     padding: EdgeInsets.zero,
  //     label: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: 6.w,
  //           height: 6.w,
  //           decoration: BoxDecoration(
  //             color: status.fontColor,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         SizedBox(width: 4.w),
  //         Text(
  //           status.label,
  //           style: AppFonts.black12w400.copyWith(color: status.fontColor),
  //         ),
  //       ],
  //     ),
  //     backgroundColor: status.backgroundColor,
  //   );
  // }

  static const List<String> _headerLabels = [
    'Project Name',
    'UPRN',
    'Address',
    'Date',
    'Assigned Surveyor',
    'Status',
    '',
  ];

  static const List<Map<String, dynamic>> _dummyData = [
    {
      'projectName': 'Wandsworth',
      'uprn': '28944',
      'address': '456 Elm Avenue, Westview',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.inProgress,
    },
    {
      'projectName': 'Greenwich',
      'uprn': '16021',
      'address': '789 Oak Street, Hillside',
      'date': 'April 15, 2023',
      'surveyorName': 'Bob Loblaw',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.inProgress,
    },
    {
      'projectName': 'LBHF',
      'uprn': '46508',
      'address': '101 Pine Lane, Valleywood',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'projectName': 'IDS',
      'uprn': '73070',
      'address': '222 Maple Drive, Brookside',
      'date': 'April 15, 2023',
      'surveyorName': 'George Michael',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'projectName': 'Guildford',
      'uprn': '5840',
      'address': '333 Cherry Court, Lakeside',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'projectName': 'Oxford',
      'uprn': '25823',
      'address': '888 Walnut Lane, Desert Ridge',
      'date': 'April 15, 2023',
      'surveyorName': 'Michael Bluth',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'projectName': 'Sutton',
      'uprn': '71045',
      'address': '111 Pine Avenue, Summerfield',
      'date': 'April 15, 2023',
      'surveyorName': 'Kitty Sanchez',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
  ];
}
