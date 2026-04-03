import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/line_chart.dart';
import '../../widgets/monthly_drop_down.dart';
import '../../widgets/number_paginator.dart';
import '../../widgets/over_view_table.dart';
import '../../widgets/survey_graph_card.dart';
import '../../widgets/trend_chart.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class SurveyorsAnalytics extends StatefulWidget {
  static const String routeName = '/surveyors-analytics';
  const SurveyorsAnalytics({super.key});

  @override
  State<SurveyorsAnalytics> createState() => _SurveyorsAnalyticsState();
}

class _SurveyorsAnalyticsState extends State<SurveyorsAnalytics> {
  String _selectedPeriod = 'Monthly';
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AdaptiveLayoutRowColumn(
            widthBetween: 16.w,
            heightBetween: 16.sp,
            children: [
              if (context.isLandscape)
                Expanded(flex: 1, child: _buildCardColumn())
              else
                _buildCardColumn(),
              if (context.isLandscape)
                Expanded(flex: 3, child: _buildLineGraph())
              else
                _buildLineGraph(),
            ],
          ),
          SizedBox(height: 20.sp),
          AdaptiveLayoutRowColumn(
            widthBetween: 20.w,
            heightBetween: 20.sp,
            expandedWidget: context.isLandscape ? true : false,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                height: 400.sp,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Inspection Progress',
                            style: AppFonts.black18w600,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        ProgressDropdown(
                          value: _selectedPeriod,
                          onChanged: (v) =>
                              setState(() => _selectedPeriod = v!),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    const Expanded(child: InspectionsTrendChart()),
                  ],
                ),
              ),

              const SurveyGraphCard(),
            ],
          ),
          SizedBox(height: 20.sp),
          Container(
            height: 500.sp,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                AdaptiveLayoutRowColumn(
                  heightBetween: 12.sp,
                  children: [
                    Text('Inspection Queue', style: AppFonts.black18w500),
                    context.isLandscape
                        ? const Spacer()
                        : const SizedBox.shrink(),
                    Row(
                      children: [
                        if (context.isLandscape)
                          SizedBox(
                            height: 43.sp,
                            width: 260.w,
                            child: const CupertinoSearchTextField(),
                          )
                        else
                          Expanded(
                            child: SizedBox(
                              height: 43.sp,
                              child: const CupertinoSearchTextField(),
                            ),
                          ),

                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
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
                SizedBox(height: 16.sp),
                const Expanded(child: OverViewTable()),
                SizedBox(height: 16.sp),
                _buildFooter(),
              ],
            ),
          ),
        ],
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

  Widget _buildLineGraph() {
    return Container(
      padding: EdgeInsets.all(16.w),
      height: 444.sp,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Properties Accessed vs Surveyed',
                  style: AppFonts.black18w500,
                ),
              ),
              SizedBox(width: 20.w),
              ProgressDropdown(
                value: _selectedPeriod,
                onChanged: (v) => setState(() => _selectedPeriod = v!),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          const Expanded(child: InspectionProgressChart()),
        ],
      ),
    );
  }
}

Widget _buildCardColumn() {
  return Column(
    children: [
      _buildCard(
        title: "Total Properties Accessed",
        count: "1,423",
        icon: TablerIcons.homeSearch,
      ),
      SizedBox(height: 12.sp),
      _buildCard(
        title: "Total Properties Surveyed",
        count: "24",
        icon: TablerIcons.userSearch,
      ),
      SizedBox(height: 12.sp),
      _buildCard(
        title: "Conversion Rate",
        count: "123",
        icon: TablerIcons.checks,
      ),
    ],
  );
}

Widget _buildCard({
  required String title,
  required String count,
  required IconData icon,
}) {
  return Container(
    width: double.infinity,
    height: 140.sp,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      image: const DecorationImage(
        image: AssetImage(PngAssets.purpleShadow),
        alignment: Alignment.topRight,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryDark, size: 24.sp),
          ),
        ),
        SizedBox(height: 8.sp),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFonts.black14w400),
              SizedBox(height: 4.sp),
              Text(count, style: AppFonts.black18w600),
            ],
          ),
        ),
      ],
    ),
  );
}
