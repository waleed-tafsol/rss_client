import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/number_paginator.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../view_models/user_management_view_model.dart';
import '../../widgets/app_table.dart';
import 'client_creation.dart';
import 'surveyor_creation.dart';

class UserManagement extends StatefulWidget {
  static const String routeName = '/user-management';
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagementViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12.w,
              children: List.generate(UserType.values.length, (index) {
                final type = UserType.values[index];
                final bool isSelected = viewModel.userType == type;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) {
                    viewModel.changeUserType(type);
                  },
                  showCheckmark: false,
                  backgroundColor: isSelected ? null : AppColors.white,
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryLight
                        : AppColors.lightGrey1,
                  ),
                  label: Text(
                    type.name.capitalize,
                    style: isSelected
                        ? AppFonts.primaryDark16w500
                        : AppFonts.black16w600,
                  ),
                );
              }),
            ),
            SizedBox(height: 20.sp),
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
          width: context.isLandscape ? 260.w : double.infinity,
          child: CupertinoSearchTextField(
            backgroundColor: AppColors.lightGrey2,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        if (context.isLandscape == true) const Spacer(),
        Container(
          height: 43.sp,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.lightGrey2,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text("Assigned Surveyor", style: AppFonts.black14w500),
              SizedBox(width: 4.w),
              Icon(
                CupertinoIcons.chevron_down,
                size: 18.sp,
                color: AppColors.textBlack,
              ),
            ],
          ),
        ),

        Container(
          height: 43.sp,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.lightGrey2,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text("Status", style: AppFonts.black14w500),
              SizedBox(width: 4.w),
              Icon(
                CupertinoIcons.chevron_down,
                size: 18.sp,
                color: AppColors.textBlack,
              ),
            ],
          ),
        ),

        Consumer<UserManagementViewModel>(
          builder: (context, userManagementViewModel, _) {
            final userType = userManagementViewModel.userType;
            return AppGradientButton(
              height: 43.sp,
              title: userType == UserType.surveyors
                  ? "New Surveyor"
                  : "New Client",
              icon: TablerIcons.plus,
              onTap: () {
                if (userType == UserType.surveyors) {
                  context.goNamed(SurveyorCreation.routeName);
                } else {
                  context.goNamed(ClientCreation.routeName);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
