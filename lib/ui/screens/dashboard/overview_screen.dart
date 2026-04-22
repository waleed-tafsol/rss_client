import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../models/responses/user_history_response.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../../utils/date_time_utils.dart';
import '../../../utils/string_utils.dart';
import '../../view_models/project_view_model.dart';
import '../../../utils/enums.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../widgets/app_custom_table.dart';
import '../../widgets/app_expansion_tile.dart';
import '../../widgets/app_network_image.dart';
import '../../widgets/status_chip.dart';
import 'property_detail.dart';

class OverViewScreen extends StatefulWidget {
  static const String routeName = '/overview';
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  final controller = MenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectViewModel>().getHistoryProjectList();
    });
    super.initState();
  }

  String selectedPeriod = 'Monthly';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildInspectionCard(),

          // SizedBox(height: 12.w),
          // AdaptiveLayoutRowColumn(
          //   expandedWidget: context.isLandscape ? true : false,
          //   widthBetween: 12.w,
          //   children: [
          //     _buildTotalCard(
          //       title: "Total Surveyors",
          //       value: "24",
          //       showStar: false,
          //     ),

          //     _buildTotalCard(
          //       title: "Total Clients",
          //       value: "123",
          //       showStar: false,
          //     ),

          //     _buildTotalCard(
          //       title: "Inspection Quality Rating",
          //       value: "4.7",
          //       showStar: true,
          //     ),
          //   ],
          // ),
          // SizedBox(height: 20.w),
          // AdaptiveLayoutRowColumn(
          //   widthBetween: 20.w,
          //   heightBetween: 20.w,
          //   expandedWidget: false,
          //   children: [
          //     if (context.isLandscape)
          //       Expanded(flex: 3, child: _buildLineGraph())
          //     else
          //       _buildLineGraph(),
          //     if (context.isLandscape)
          //       Expanded(flex: 2, child: _buildBarGraph())
          //     else
          //       _buildBarGraph(),
          //   ],
          // ),
          SizedBox(height: 20.w),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdaptiveLayoutRowColumn(
                  widthBetween: 12.w,
                  heightBetween: 12.w,
                  children: [
                    Text('Inspection Queue', style: AppFonts.black18w500),
                    context.isLandscape
                        ? const Spacer()
                        : const SizedBox.shrink(),

                    Row(
                      children: [
                        if (context.isLandscape)
                          SizedBox(
                            width: 260.w,
                            child: CupertinoSearchTextField(
                              backgroundColor: AppColors.lightGrey2,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          )
                        else
                          Expanded(
                            child: CupertinoSearchTextField(
                              backgroundColor: AppColors.lightGrey2,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View All", style: AppFonts.black14w500),
                              SizedBox(width: 4.w),
                              Icon(
                                TablerIcons.arrowUpRight,
                                size: 16.sp,
                                color: AppColors.textBlack,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.w),
                Row(
                  mainAxisSize: .max,
                  children: [
                    const StatusChip(status: Status.inprogress),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: Divider(color: AppColors.lightGrey2, height: 0),
                    ),
                  ],
                ),

                SizedBox(height: 16.w),
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
                        subtitle: Text('71045', style: AppFonts.black18w500),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(TablerIcons.arrowUpRight, size: 24.sp),
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
                          SizedBox(
                            width: 250.w,
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text('Status', style: AppFonts.grey14w400),
                                const StatusChip(status: Status.inprogress),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.w),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    const StatusChip(status: Status.completed),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: Divider(color: AppColors.lightGrey2, height: 0),
                    ),
                  ],
                ),

                SizedBox(height: 16.w),
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
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                          title: projectList[index]?.name?.capitalize ?? 'N/A',
                          subtitle:
                              '${projectList[index]?.propertiesCount} Properties',
                          actions: const [],
                          child: _buildTable(
                            projectList[index]?.properties ?? [],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
            1 => Text(property.address ?? 'N/A', style: AppFonts.black14w400),
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
            3 => const StatusChip(status: Status.completed),
            4 => Text(
              property.date?.toLongDate ?? 'N/A',
              style: AppFonts.black14w400,
            ),
            5 => MyMenuWidget(propertyId: property.id.toString()),
            int() => throw UnimplementedError(),
          };
        });
      }),
      flexValues: [90.w, 180.w, 200.w, 180.w, 150.w, 70.w],
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

  Widget _buildInspectionCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),

                padding: EdgeInsets.all(12.w),
                child: const Icon(
                  TablerIcons.reportSearch,
                  color: AppColors.primaryDark,
                  size: 24,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Inspections", style: AppFonts.black14w400),
                  SizedBox(height: 4.w),
                  Text("365", style: AppFonts.black18w600),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.w),
          AdaptiveLayoutRowColumn(
            widthBetween: 12.w,
            heightBetween: 12.w,
            children: [
              if (context.isLandscape)
                Expanded(flex: 2, child: _buildProgressBar())
              else
                _buildProgressBar(),

              if (context.isLandscape)
                Expanded(flex: 3, child: _buildCompeletedBar())
              else
                _buildCompeletedBar(),

              if (context.isLandscape)
                Expanded(child: _buildPendingBar())
              else
                _buildPendingBar(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildPendingBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LinearProgressIndicator(
        value: 1.0,
        minHeight: 23.h,
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(8.r),
        backgroundColor: AppColors.primaryDark,
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          Text("Pending:", style: AppFonts.black14w400),
          Text("  23", style: AppFonts.black14w600),
        ],
      ),
    ],
  );
}

Widget _buildCompeletedBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LinearProgressIndicator(
        value: 1.0,
        minHeight: 23.h,
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(8.r),
        backgroundColor: AppColors.primaryDark,
      ),
      SizedBox(height: 16.w),
      Row(
        children: [
          Text("Completed:", style: AppFonts.black14w400),
          Text("  289", style: AppFonts.black14w600),
        ],
      ),
    ],
  );
}

Widget _buildProgressBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LinearProgressIndicator(
        value: 1.0,
        minHeight: 23.h,
        color: AppColors.purpleColor,
        borderRadius: BorderRadius.circular(8.r),
        backgroundColor: AppColors.primaryDark,
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          Text("In Progress:", style: AppFonts.black14w400),
          Text("  53", style: AppFonts.black18w600),
        ],
      ),
    ],
  );
}

class MyMenuWidget extends StatefulWidget {
  final String propertyId;
  const MyMenuWidget({super.key, required this.propertyId});

  @override
  State<MyMenuWidget> createState() => _MyMenuWidgetState();
}

class _MyMenuWidgetState extends State<MyMenuWidget> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _controller,
      menuChildren: [
        ListTile(
          onTap: () {
            final projectVM = context.read<ProjectViewModel>();
            _controller.close();
            projectVM.setSelectedPropertyId(int.parse(widget.propertyId));
            context.goNamed(
              PropertyDetail.routeName,
              extra: int.parse(widget.propertyId),
            );
          },
          leading: Icon(TablerIcons.eye, size: 24.sp),
          horizontalTitleGap: 16.w,
          minLeadingWidth: 24.sp,
          title: Text('View Details', style: AppFonts.grey14w400),
          contentPadding: EdgeInsets.zero,
        ),
        // ListTile(
        //   onTap: () {
        //     context.read<ProjectViewModel>().callDeleteProperty(
        //       id: widget.propertyId,
        //     );
        //     _controller.close();
        //   },
        //   leading: Icon(TablerIcons.trash, size: 24.sp, color: AppColors.red),
        //   horizontalTitleGap: 16.w,
        //   minLeadingWidth: 24.sp,
        //   title: Text('Detele', style: AppFonts.grey14w400),
        //   contentPadding: EdgeInsets.zero,
        // ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          icon: Icon(TablerIcons.dots, size: 16.sp),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
    );
  }
}
