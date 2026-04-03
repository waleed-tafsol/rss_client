import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../../utils/enums.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/number_paginator.dart';
import '../../widgets/project_management_card.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../widgets/app_dropdown.dart';

class ProjectManagement extends StatefulWidget {
  static const String routeName = '/project-management';
  const ProjectManagement({super.key});

  @override
  State<ProjectManagement> createState() => _ProjectManagementState();
}

class _ProjectManagementState extends State<ProjectManagement> {
  String? _selectedNoOfProperties;
  static const List<String> noOfProperties = [
    'option 1',
    'option 2',
    'option 3',
  ];
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AdaptiveLayoutRowColumn(
              heightBetween: 12.w,
              children: [
                SizedBox(
                  width: context.isLandscape ? 260.w : double.infinity,
                  height: 43.w,
                  child: const CupertinoSearchTextField(),
                ),

                context.isLandscape ? const Spacer() : const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (context.isLandscape)
                      AppDropdown<String>(
                        hint: 'No of Properties',
                        items: noOfProperties,
                        value: _selectedNoOfProperties,
                        builder: (value) =>
                            Text(value, style: AppFonts.black14w400),
                        onChanged: (value) {
                          setState(() {
                            _selectedNoOfProperties = value;
                          });
                        },
                      )
                    else
                      Expanded(
                        child: AppDropdown<String>(
                          hint: 'No of Properties',
                          items: noOfProperties,
                          value: _selectedNoOfProperties,
                          builder: (value) =>
                              Text(value, style: AppFonts.black14w400),
                          onChanged: (value) {
                            setState(() {
                              _selectedNoOfProperties = value;
                            });
                          },
                        ),
                      ),
                    SizedBox(width: 12.w),

                    const AppGradientButton(
                      title: 'New Project',
                      icon: TablerIcons.plus,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.w),
            MasonryGridView.count(
              crossAxisCount: context.isLandscape ? 4 : 1,
              mainAxisSpacing: 16.w,
              crossAxisSpacing: 16.w,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const ProjectManagementCard(
                location: "Wandsworth",
                propertyCount: 9,
                lastUpdated: "Feb 16, 2026",
                status: InspectionStatus.completed,
              ),
              itemCount: 7,
            ),
            SizedBox(height: 16.w),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Row _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
