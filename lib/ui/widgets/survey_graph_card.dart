import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/ui/survey_data.dart';
import 'monthly_drop_down.dart';

class SurveyGraphCard extends StatelessWidget {
  const SurveyGraphCard({super.key});

  static const List<SurveyData> surveyData = [
    SurveyData(month: 'Jan', y: 70, data: Offset(30, 70)),
    SurveyData(month: 'Feb', y: 130, data: Offset(40, 130)), // Feb
    SurveyData(month: 'Mar', y: 65, data: Offset(122, 65)), // Mar
    SurveyData(month: 'Apr', y: 85, data: Offset(70, 85)), // Apr
    SurveyData(month: 'May', y: 72, data: Offset(45, 72)), // May
    SurveyData(month: 'June', y: 120, data: Offset(30, 120)), // Jun
    SurveyData(month: 'July', y: 75, data: Offset(100, 75)),
    SurveyData(month: 'Aug', y: 130, data: Offset(50, 130)), // Aug
    SurveyData(month: 'Sep', y: 68, data: Offset(70, 68)), // Sep
    SurveyData(month: 'Oct', y: 85, data: Offset(70, 85)), // Oct
    SurveyData(month: 'Nov', y: 73, data: Offset(24, 73)), // Nov
    SurveyData(month: 'Dec', y: 130, data: Offset(100, 130)), // Dec
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 16.sp,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Assigned vs Completed Surveys',
                    style: AppFonts.black18w500,
                  ),
                ),
                SizedBox(width: 20.w),
                ProgressDropdown(value: 'Monthly', onChanged: (v) {}),
              ],
            ),
            SfCartesianChart(
              plotAreaBorderWidth: 0,
              legend: const Legend(isVisible: false),
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(width: 0),
                axisLine: AxisLine(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorGridLines: MajorGridLines(
                  width: 0.5.w,
                  color: AppColors.grey.withValues(alpha: 0.2),
                  dashArray: const [5, 5],
                ),
              ),
              series: [
                StackedColumnSeries<SurveyData, String>(
                  dataSource: surveyData,
                  xValueMapper: (SurveyData data, int index) => data.month,
                  yValueMapper: (SurveyData data, int index) => data.data.dx,
                  borderRadius: BorderRadius.circular(30.r),
                  gradient: AppColors.greenGradient,
                  borderGradient: AppColors.greenGradient1,
                ),
                StackedColumnSeries<SurveyData, String>(
                  dataSource: surveyData,
                  xValueMapper: (SurveyData data, int index) => data.month,
                  yValueMapper: (SurveyData data, int index) => data.data.dy,
                  gradient: AppColors.blackGradient,
                  borderGradient: AppColors.blackGradient,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
