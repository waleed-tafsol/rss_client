import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../utils/context_utils.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../screens/dashboard/property_detail.dart';
import '../../utils/enums.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'status_chip.dart';

class ProjectDetailTable extends StatelessWidget {
  const ProjectDetailTable({super.key});

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
          columnCount: 6,
          rowCount: _dummyData.length + 1,
          columnBuilder: (index) => _buildColumnSpan(index, context),
          rowBuilder: _buildRowSpan,
          cellBuilder: _buildCell,
        ),
      ),
    );
  }

  TableSpan _buildColumnSpan(int index,BuildContext context) {
     final double width;
    switch (index) {
      case 0:
        width = 175.w;
        break;
      case 1:
        width = 254.w;
        break;
      case 2:
        width = 123.w;
        break;
      case 3:
        width = 160.w;
        break;
      case 4:
        width = 120.w;
        break;
      case 5:
        width = 70.w;
      default:
        width = 150.w;
    }
     if (context.isMobile) {
      return TableSpan(extent: FixedSpanExtent(width));
    }
    return TableSpan(extent: FractionalSpanExtent(width / 881));
  }

  TableSpan _buildRowSpan(int index) {
    return TableSpan(
      extent: FixedTableSpanExtent(43.sp),
      backgroundDecoration: TableSpanDecoration(
        border: index == 0
            ? const SpanBorder(trailing: BorderSide(color: AppColors.lightGrey1))
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
        child = Text(data['uprn'], style: AppFonts.black14w400);
        break;

      case 1:
        child = Text(data['address'], style: AppFonts.black14w400);
        break;

      case 2:
        child = Text(data['date'], style: AppFonts.black14w400);
        break;
      case 3:
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14.r,
              backgroundColor: AppColors.lightGrey1,
              backgroundImage: NetworkImage(data['surveyorImage']),
            ),
            SizedBox(width: 12.w),
            Text(data['surveyorName'], style: AppFonts.black14w500),
          ],
        );
        break;
      case 4:
        child = StatusChip(status: data['status']);
        break;
      case 5:
        final controller = MenuController();
        child = MenuAnchor(
          controller: controller,

          menuChildren: [
            ListTile(
              onTap: () {
                context.goNamed(PropertyDetail.routeName);
              },
              leading: Icon(TablerIcons.eye, size: 24.sp),
              horizontalTitleGap: 16.w,
              minLeadingWidth: 24.sp,
              title: Text('View Details', style: AppFonts.grey14w400),
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
    'UPRN',
    'Address',
    'Date',
    'Assigned Surveyor',
    'Status',
    '',
  ];

  static const List<Map<String, dynamic>> _dummyData = [
    {
      'uprn': '28944',
      'address': '456 Elm Avenue, Westview',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.inProgress,
    },
    {
      'uprn': '16021',
      'address': '789 Oak Street, Hillside',
      'date': 'April 15, 2023',
      'surveyorName': 'Bob Loblaw',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.inProgress,
    },
    {
      'uprn': '46508',
      'address': '101 Pine Lane, Valleywood',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'uprn': '73070',
      'address': '222 Maple Drive, Brookside',
      'date': 'April 15, 2023',
      'surveyorName': 'George Michael',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'uprn': '5840',
      'address': '333 Cherry Court, Lakeside',
      'date': 'April 15, 2023',
      'surveyorName': 'Maeby Funke',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'uprn': '25823',
      'address': '888 Walnut Lane, Desert Ridge',
      'date': 'April 15, 2023',
      'surveyorName': 'Michael Bluth',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
    {
      'uprn': '71045',
      'address': '111 Pine Avenue, Summerfield',
      'date': 'April 15, 2023',
      'surveyorName': 'Kitty Sanchez',
      'surveyorImage': 'https://picsum.photos/400/400',
      'status': InspectionStatus.upcoming,
    },
  ];
}
