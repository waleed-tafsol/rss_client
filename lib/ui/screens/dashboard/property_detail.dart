import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/property_detail_table.dart';
import '../../widgets/status_chip.dart';
import '../../../utils/enums.dart';
import '../../../utils/inspection_status.dart';
import '../../../utils/property_detail_filter.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class PropertyDetail extends StatelessWidget {
  static const String routeName = '/property-detail';
  PropertyDetail({super.key});
  final ValueNotifier<PropertyDetailFilter> selectedFilter = ValueNotifier(
    PropertyDetailFilter.inspectionChecklist,
  );

  List<CostSummaryData> costSummaryDataList = [
    CostSummaryData(title: "Estimated Total Cost", value: "8,000"),
    CostSummaryData(title: "Repairs:", value: "2,000"),
    CostSummaryData(title: "Stock Replacement:", value: "3,500"),
  ];

  List<ProgressData> progressDataList = [
    ProgressData(
      title: "Stock",
      progress: 0.8,
      status: InspectionStatus.inProgress,
    ),
    ProgressData(
      title: "Attributes",
      progress: 1.0,
      status: InspectionStatus.completed,
    ),
    ProgressData(
      title: "Windows",
      progress: 0.5,
      status: InspectionStatus.inProgress,
    ),
    ProgressData(
      title: "D&M Survey",
      progress: 0.2,
      status: InspectionStatus.upcoming,
    ),
    ProgressData(
      title: "Repairs",
      progress: 0.9,
      status: InspectionStatus.inProgress,
    ),
    ProgressData(
      title: "HHSRS",
      progress: 1.0,
      status: InspectionStatus.completed,
    ),
  ];

  List<String> subfilters = ["Externals", "Internals", "Energy"];
  List<String> filters = [
    "Stock",
    "Attributes",
    "Windows",
    "D&M Survey",
    "Repairs",
    "HHSRS",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: .all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(22.w),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        TablerIcons.homeSearch,
                        color: AppColors.primaryDark,
                        size: 44.sp,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UPRN:", style: AppFonts.grey14w400),
                        Text("71045", style: AppFonts.black24w600),
                      ],
                    ),
                    const Spacer(),
                    const StatusChip(status: InspectionStatus.inProgress),
                  ],
                ),
                SizedBox(height: 16.sp),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Wrap(
                    alignment: .start,
                    runSpacing: 16.sp,
                    children: List.generate(
                      detailList.length,
                      (index) => _buildDetailColumn(
                        detailList[index].title,
                        detailList[index].value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),
        AdaptiveLayoutRowColumn(
            widthBetween: 20.w,
            heightBetween: 20.sp,
            expandedWidget: context.isLandscape ? true : false,
            children: [
              _buildTenantdetail(
                title: "Tenant Details",
                name: "George Michael",
                email: "michael@gmail.com",
                phone: "+1 234 567 890",
                imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
                context: context,
              ),

              _buildTenantdetail(
                title: "Assigned Surveyor",
                name: "Michael Smith",
                email: "michael@gmail.com",
                phone: "+1 234 567 890",
                imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
                context: context,
              ),
            ],
          ),  SizedBox(height: 20.sp),
          Container(
            padding: .all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                // In your widget tree
                 AdaptiveLayoutRowColumn(
                  alignment: .spaceBetween,
                
                  children: [
                    ValueListenableBuilder<PropertyDetailFilter>(
                      valueListenable: selectedFilter,
                      builder: (context, current, _) {
                        return AdaptiveLayoutRowColumn(
                          widthBetween: 8.w,
                          heightBetween: 12.sp,
                          children: PropertyDetailFilter.values.map((filter) {
                            final isSelected = current == filter;
                            return GestureDetector(
                              onTap: () => selectedFilter.value = filter,
                              child: Container(
                                width: context.isLandscape
                                    ? null
                                    : double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 9.sp,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryLight
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryLight
                                        : AppColors.lightGrey2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    filter.label,
                                    style: AppFonts.black16w500.copyWith(
                                      color: isSelected
                                          ? AppColors.primaryDark
                                          : AppColors.textBlack,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    Container(
                      height: 43.sp,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.textBlack,

                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Download Full Report ',
                            style: AppFonts.white14w500,
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            TablerIcons.download,
                            size: 18.sp,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),
                ValueListenableBuilder<PropertyDetailFilter>(
                  valueListenable: selectedFilter,
                  builder: (context, current, _) {
                    if (selectedFilter.value ==
                        PropertyDetailFilter.inspectionChecklist) {
                      return Column(
                        children: List.generate(filters.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(8.r),
                              ),

                              tilePadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.sp,
                              ),
                              collapsedBackgroundColor: AppColors.fillColor,
                              backgroundColor: AppColors.fillColor,
                              title: Row(
                                children: [
                                  Text(
                                    filters[index],
                                    style: AppFonts.black16w500,
                                  ),
                                  SizedBox(width: 8.w),

                                  Icon(
                                    TablerIcons.pencil,
                                    size: 16.sp,
                                    color: AppColors.textBlack,
                                  ),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: List.generate(
                                      subfilters.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16.0,
                                        ),
                                        child: ExpansionTile(
                                          tilePadding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 12.sp,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          collapsedBackgroundColor:
                                              AppColors.white,
                                          backgroundColor: AppColors.white,
                                          title: Text(
                                            subfilters[index],
                                            style: AppFonts.black16w500,
                                          ),
                                          children: const [
                                            PropertyDetailItemsTable(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    } else if (selectedFilter.value ==
                        PropertyDetailFilter.modulesOverview) {
                      return MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.sp,
                        crossAxisSpacing: 16.w,
                        itemBuilder: (context, index) {
                          final progressData = progressDataList[index];
                          return _buildProgressBar(
                            title: progressData.title,
                            progress: progressData.progress,
                            status: progressData.status,
                          );
                        },
                        itemCount: progressDataList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      );
                    } else {
                      return AdaptiveLayoutRowColumn(
                        widthBetween: 16.w,
                        heightBetween: 16.sp,
                        expandedWidget: context.isLandscape ? true : false,
                        children: List.generate(
                          costSummaryDataList.length,
                          (index) => _buildCostSummary(
                            title: costSummaryDataList[index].title,
                            value: costSummaryDataList[index].value,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: AppFonts.black16w500),
          SizedBox(height: 16.sp),
          Text("\$$value", style: AppFonts.black24w600),
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required String title,
    required double progress,
    required InspectionStatus status,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: AppFonts.black16w500),
          SizedBox(height: 16.sp),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(status.label, style: AppFonts.black12w400),
              Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: AppFonts.black12w500,
              ),
            ],
          ),
          SizedBox(height: 4.sp),
          LinearProgressIndicator(
            value: progress,
            color: status.fontColor,
            backgroundColor: AppColors.lightGrey2,
            stopIndicatorRadius: 30.r,
            borderRadius: BorderRadius.circular(30.r),
          ),
        ],
      ),
    );
  }

 Widget _buildTenantdetail({
    required String title,
    required String name,
    required String email,
    required String phone,
    required String imageUrl,
    required BuildContext context,
  }) {
    return Container(
      padding:  EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: context.isLandscape
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(title, style: AppFonts.black18w500),
           SizedBox(height: 16.sp),
          AdaptiveLayoutRowColumn(
            heightBetween: 16.sp,
            widthBetween: 16.w,

            children: [
               CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColors.lightGrey1,
                backgroundImage:const NetworkImage('https://picsum.photos/400/400'),
              ),

              Column(
                crossAxisAlignment: context.isLandscape
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text(name, style: AppFonts.black18w500),
                   SizedBox(height: 8.w),
                  AdaptiveLayoutRowColumn(
                    widthBetween: 12.w,
                    heightBetween: 12.w,

                    children: [
                      Row(
                        mainAxisAlignment: context.isLandscape
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          const Icon(
                            TablerIcons.mail,
                            size: 16,
                            color: AppColors.textBlack,
                          ),
                          SizedBox(width: 10.w),
                          Text(email, style: AppFonts.black14w400),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: context.isLandscape
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          const Icon(
                            TablerIcons.phone,
                            size: 16,
                            color: AppColors.textBlack,
                          ),
                           SizedBox(width: 10.w),
                          Text(phone, style: AppFonts.black14w400),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              context.isLandscape ? const Spacer() : const SizedBox.shrink(),
              IconButton(
                icon: const Icon(TablerIcons.arrowUpRight),
                iconSize: 24.sp,
                color: AppColors.textBlack,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildDetailColumn(String title, String value) {
    return SizedBox(
      width: 207.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppFonts.grey14w400),
          SizedBox(width: 8.w),
          Text(value, style: AppFonts.black14w400),
        ],
      ),
    );
  }
}

class Detail {
  final String title;
  final String value;
  Detail({required this.title, required this.value});
}

final List<Detail> detailList = [
  Detail(title: "Date:", value: "April 15, 2023"),
  Detail(title: "Post Code:", value: "1234"),
  Detail(title: "Town:", value: "Oxford"),
  Detail(title: "Year Build:", value: "Feb 16, 2026"),
  Detail(title: "Property Type:", value: "Mid Terrace House"),
  Detail(title: "Address 1:", value: "764 Howell Manors"),
  Detail(title: "Address 2:", value: "26931 Bayer Village"),
];

class ProgressData {
  final String title;
  final double progress;
  final InspectionStatus status;

  ProgressData({
    required this.title,
    required this.progress,
    required this.status,
  });
}

class CostSummaryData {
  final String title;
  final String value;

  CostSummaryData({required this.title, required this.value});
}
