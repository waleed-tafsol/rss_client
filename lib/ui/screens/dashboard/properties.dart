import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../models/responses/user_history_response.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../../utils/date_time_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

import '../../view_models/project_view_model.dart';
import '../../widgets/app_custom_table.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_expansion_tile.dart';
import '../../widgets/app_network_image.dart';
import '../../widgets/number_paginator.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';

import '../../widgets/status_chip.dart';
import 'property_detail.dart';

class Properties extends StatefulWidget {
  static const String routeName = '/properties';
  const Properties({super.key});

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  final controller = MenuController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectViewModel>().getHistoryProjectList();
    });

    super.initState();
  }

  int _currentPage = 0;

  String? _selectedAssignedSurveyor;
  static const List<String> assignedSurveyorList = [
    'option 1',
    'option 2',
    'option 3',
  ];

  @override
  Widget build(BuildContext context) {
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
                  Consumer<ProjectViewModel>(
                    builder: (context, projectVM, _) {
                      final loading = projectVM.loading;
                      final projectList = projectVM.historyProjectData;
                      if (loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (projectList.isEmpty) {
                        return const Center(child: Text('No Data Found'));
                      }
                      return Expanded(
                        child: ListView.separated(
                          itemCount: projectList.length,
                          separatorBuilder: (_, _) => SizedBox(height: 8.h),
                          itemBuilder: (_, index) {
                            return AppExpansionTile(
                              leading: Container(
                                height: 48.w,
                                width: 48.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryLight,
                                ),
                                child: Icon(
                                  TablerIcons.mapPin,
                                  size: 24.sp,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              title:
                                  projectList[index]?.name?.capitalize ?? 'N/A',
                              subtitle:
                                  '${projectList[index]?.propertiesCount} Properties',
                              actions: const [],
                              child: _buildTable(
                                projectList[index]?.properties ?? [],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppCustomTable _buildTable(List<Property> properties) {
    return AppCustomTable(
      columns: const ['URPN', 'Address', 'Client', 'Status', 'Date', ''],
      rows: List.generate(properties.length, (rIndex) {
        return List.generate(6, (cIndex) {
          final property = properties[rIndex];
          return switch (cIndex) {
            0 => Text(property.uprn ?? 'N/A', style: AppFonts.black14w400),
            1 => Text(property.address1 ?? 'N/A', style: AppFonts.black14w400),
            2 => Row(
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
                Text(
                  property.tenantName?.capitalize ?? 'N/A',
                  style: AppFonts.black14w400,
                ),
              ],
            ),
            3 => const StatusChip(status: InspectionStatus.completed),
            4 => Text(
              property.date?.toLongDate ?? 'N/A',
              style: AppFonts.black14w400,
            ),
            5 => MenuAnchor(
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
                icon: Icon(TablerIcons.dots, size: 24.sp),
              ),
            ),

            int() => throw UnimplementedError(),
          };
        });
      }),
      flexValues: [90.w, 180.w, 200.w, 180.w, 150.w, 70.w],
    );
  }

  Widget _buildFooter() {
    return Consumer<ProjectViewModel>(
      builder: (context, projectVM, _) {
        return Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'Showing Results ${_currentPage + 1}-${projectVM.totalPages}',
              style: AppFonts.grey14w400,
            ),
            NumberPaginator(
              totalPages: projectVM.page,
              currentPage: _currentPage,
              onPageChanged: (page) {
                final changepage = page + 1;
                projectVM.setPage(changepage);
                projectVM.getProjectList();
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ],
        );
      },
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
