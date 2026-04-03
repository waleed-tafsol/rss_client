import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/line_chart.dart';
import '../../widgets/monthly_drop_down.dart';
import '../../widgets/over_view_table.dart';
import '../../widgets/trend_chart.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class OverViewScreen extends StatefulWidget {
  static const String routeName = '/overview';
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  String selectedPeriod = 'Monthly';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildInspectionCard(),
          SizedBox(height: 12.w),
          AdaptiveLayoutRowColumn(
            expandedWidget: context.isLandscape ? true : false,
            widthBetween: 12.w,
            children: [
              _buildTotalCard(
                title: "Total Surveyors",
                value: "24",
                showStar: false,
              ),

              _buildTotalCard(
                title: "Total Clients",
                value: "123",
                showStar: false,
              ),

              _buildTotalCard(
                title: "Inspection Quality Rating",
                value: "4.7",
                showStar: true,
              ),
            ],
          ),
          SizedBox(height: 20.w),
          AdaptiveLayoutRowColumn(
            widthBetween: 20.w,
            heightBetween: 20.w,
            expandedWidget: false,
            children: [
              if (context.isLandscape)
                Expanded(flex: 3, child: _buildLineGraph())
              else
                _buildLineGraph(),
              if (context.isLandscape)
                Expanded(flex: 2, child: _buildBarGraph())
              else
                _buildBarGraph(),
            ],
          ),
           SizedBox(height: 20.w),
          Container(
            height: 477.w,
            padding:  EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
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
                const Expanded(child: OverViewTable()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineGraph() {
    return Container(
      height: 400.w,

      padding:  EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Inspection Progress', style: AppFonts.black18w600),
              ProgressDropdown(
                value: selectedPeriod,
                onChanged: (v) => setState(() => selectedPeriod = v!),
              ),
            ],
          ),
           SizedBox(height: 16.w),
          const Expanded(child: InspectionProgressChart()),
        ],
      ),
    );
  }

  Widget _buildBarGraph() {
    return Container(
      padding:  EdgeInsets.all(16.w),
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Inspection Progress', style: AppFonts.black18w600),
              ProgressDropdown(
                value: selectedPeriod,
                onChanged: (v) => setState(() => selectedPeriod = v!),
              ),
            ],
          ),
           SizedBox(height: 16.w),
          const Expanded(child: InspectionsTrendChart()),
        ],
      ),
    );
  }

  Widget _buildInspectionCard() {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.darkGrey,
                  shape: BoxShape.circle,
                ),

                padding:  EdgeInsets.all(12.w),
                child: const Icon(
                  TablerIcons.reportSearch,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
               SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Inspections", style: AppFonts.white14w400),
                   SizedBox(height: 4.w),
                  Text("365", style: AppFonts.white18w600),
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
        minHeight: 23.w,
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(8.r),
        backgroundColor: AppColors.primaryDark,
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          Text("Pending:", style: AppFonts.white14w400),
          Text("  23", style: AppFonts.white14w600),
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
          Text("Completed:", style: AppFonts.white14w400),
          Text("  289", style: AppFonts.white14w600),
        ],
      ),
    ],
  );
}

Widget _buildTotalCard({
  required String title,
  required String value,
  required bool showStar,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Row(
      mainAxisSize: .max,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            TablerIcons.userSearch,
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppFonts.black14w400),
            SizedBox(height: 4.w),
            Row(
              children: [
                Text(value, style: AppFonts.black18w600),
                SizedBox(width: 4.w),
                if (showStar)
                   Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.amber,
                    size: 16.sp,
                  ),
              ],
            ),
          ],
        ),
      ],
    ),
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
          Text("In Progress:", style: AppFonts.white14w400),
          Text("  53", style: AppFonts.white14w600),
        ],
      ),
    ],
  );
}
