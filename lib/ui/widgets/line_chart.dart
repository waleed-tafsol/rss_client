import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InspectionProgressChart extends StatefulWidget {
  const InspectionProgressChart({super.key});

  @override
  State<InspectionProgressChart> createState() =>
      _InspectionProgressChartState();
}

class _InspectionProgressChartState extends State<InspectionProgressChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // Customize the tooltip to match the image style
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false, // Disables the tooltip's own marker highlight
      activationMode: ActivationMode.singleTap,

      header: '',

      textStyle: AppFonts.black12w400,
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),

      borderWidth: 1.w,
      format: 'point.x',

      builder:
          (
            dynamic data,
            dynamic point,
            dynamic series,
            int pointIndex,
            int seriesIndex,
          ) {
            final ChartData item = data as ChartData;
            final String monthName = DateFormat('MMMM').format(item.month);
            return Material(
              // 1. Added Material to prevent layout/styling bleed
              type: MaterialType.transparency,
              child: Container(
                width: 150.w,
                padding: EdgeInsets.all(10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(monthName, style: AppFonts.black14w600),
                    SizedBox(height: 8.sp),
                    _buildTooltipRow(
                      AppColors.purpleColor,
                      'Completed',
                      item.completed,
                    ),
                    SizedBox(height: 4.sp),
                    _buildTooltipRow(
                      AppColors.textBlack,
                      'In Progress',
                      item.inProgress,
                    ),
                  ],
                ),
              ),
            );
          },
    );
    super.initState();
  }

  Widget _buildTooltipRow(Color color, String label, double value) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Vital: prevents horizontal expansion
      children: [
        Icon(Icons.circle, size: 8.w, color: color),
        SizedBox(width: 5.w),
        Text(
          '$label: ${value.toInt()}',
          style: TextStyle(color: const Color(0xFF666666), fontSize: 12.sp),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data based on the image
    final List<ChartData> chartData = [
      ChartData(DateTime(2023, 1), 90, 80),
      ChartData(DateTime(2023, 1, 15), 105, 88), // mid-Jan
      ChartData(DateTime(2023, 2), 120, 95),
      ChartData(DateTime(2023, 2, 15), 115, 92), // mid-Feb
      ChartData(DateTime(2023, 3), 122, 80), // March point (low in-progress)
      ChartData(DateTime(2023, 4), 140, 105),
      ChartData(DateTime(2023, 4, 15), 135, 102), // mid-Apr
      ChartData(DateTime(2023, 5), 125, 100),
      ChartData(DateTime(2023, 5, 15), 130, 98), // mid-May
      ChartData(DateTime(2023, 6), 150, 110),
    ];

    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,

      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.MMM(),
        intervalType: DateTimeIntervalType.months,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: AppFonts.grey10w400,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 1,
      ),
      // Y-Axis (Count)
      primaryYAxis: NumericAxis(
        minimum: 60,
        maximum: 160,
        interval: 20,
        interactiveTooltip: const InteractiveTooltip(
          enable: true,
          format: 'point.y',
        ),
        opposedPosition: true, // Labels on the right side
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: const TextStyle(color: Colors.grey),
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: Colors.grey[300]!,
          dashArray: const <double>[5, 5],
        ),
      ),
      // Set chart border
      plotAreaBorderWidth: 0,
      series: <CartesianSeries<ChartData, DateTime>>[
        // The main completed inspections line with area fill
        SplineAreaSeries<ChartData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.month,
          yValueMapper: (ChartData data, _) => data.completed,
          name: 'Completed',
          // Define the gradient for the fill
          gradient: LinearGradient(
            colors: <Color>[
              const Color(0xFFE6E0F8).withValues(alpha: 0.8), // Top color
              const Color(0xFFF3E5F5).withValues(alpha: 0.01), // Bottom color
            ],
            stops: const <double>[0.1, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

          borderWidth: 2.42.w,
          borderColor: AppColors.purpleColor, // Purple line color
          borderDrawMode: BorderDrawMode.top,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
        // The in-progress dashed line
        SplineSeries<ChartData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.month,
          yValueMapper: (ChartData data, _) => data.inProgress,
          name: 'In Progress',
          color: Colors.black, // Dark blue dashed line
          width: 2,
          dashArray: const <double>[5, 5], // Creates the dashed effect
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}

// Simple data class
class ChartData {
  ChartData(this.month, this.completed, this.inProgress);
  final DateTime month;
  final double completed;
  final double inProgress;
}
