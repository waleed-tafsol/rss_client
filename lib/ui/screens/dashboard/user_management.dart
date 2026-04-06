import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

import '../../widgets/app_dropdown.dart';
import '../../widgets/number_paginator.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';

import '../../view_models/user_management_view_model.dart';
import '../../widgets/app_table.dart';

class UserManagement extends StatefulWidget {
  static const String routeName = '/user-management';
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  int _currentPage = 0;

  String? _selectedAssignedSurveyor;
  static const List<String> assignedSurveyorList = [
    'option 1',
    'option 2',
    'option 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagementViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    spacing: 16.sp,
                    children: [
                      _buildHeader(),
                      const Expanded(child: AppTable()),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Row _buildFooter() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text('Showing Results 1-11', style: AppFonts.grey14w400),
        NumberPaginator(
          totalPages: 10,
          currentPage: _currentPage,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return AdaptiveLayoutRowColumn(
      expandedWidget: context.isLandscape ? false : true,
      widthBetween: 12.w,
      heightBetween: 12.sp,
      children: [
        SizedBox(
          height: 43.w,
          width: context.isLandscape ? 260.w : double.infinity,
          child: CupertinoSearchTextField(
            backgroundColor: AppColors.lightGrey2,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        if (context.isLandscape == true) const Spacer(),
        AppDropdown(
          fillColor: AppColors.lightGrey2,
          hint: "Assigned Surveyor",
          items: assignedSurveyorList,
          value: _selectedAssignedSurveyor,
          builder: (value) => Text(value, style: AppFonts.black14w400),
          onChanged: (value) {
            setState(() {
              _selectedAssignedSurveyor = value;
            });
          },
        ),
        SizedBox(
          child: AppDropdown(
            fillColor: AppColors.lightGrey2,
            items: InspectionStatus.values,
            builder: (item) =>
                Text(item.name.capitalize, style: AppFonts.black14w400),
            hint: 'Status',
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
