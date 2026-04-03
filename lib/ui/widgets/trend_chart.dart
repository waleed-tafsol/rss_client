import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InspectionsTrendChart extends StatefulWidget {
  const InspectionsTrendChart({super.key});

  @override
  State<InspectionsTrendChart> createState() => _InspectionsTrendChartState();
}

class _InspectionsTrendChartState extends State<InspectionsTrendChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      builder:
          (
            dynamic data,
            dynamic point,
            dynamic series,
            int index,
            int seriesIndex,
          ) {
            final TrendData item = data as TrendData;
            return Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.monthName, style: AppFonts.black12w600),
                  SizedBox(height: 4.sp),
                  Text(
                    'Inspections: ${item.count}',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            );
          },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TrendData> chartData = [
      TrendData('Jan', 150),
      TrendData('Feb', 225),
      TrendData('Mar', 140),
      TrendData('Apr', 175),
      TrendData('May', 150),
      TrendData('Jun', 225),
    ];

    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: AppFonts.grey10w400,
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 300,
        interval: 50,
        opposedPosition: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: MajorGridLines(
          width: 0.5.w,
          color: Colors.grey[200],
          dashArray: const <double>[5, 5],
        ),
      ),
      plotAreaBorderWidth: 0,
      series: <CartesianSeries<TrendData, String>>[
        ColumnSeries<TrendData, String>(
          dataSource: chartData,
          xValueMapper: (TrendData data, _) => data.monthName,
          yValueMapper: (TrendData data, _) => data.count,
          width: 0.8,
          spacing: 0.2,
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            colors: [Color(0xFF6A13CC), Color(0xFF3B0F6D)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}

class TrendData {
  TrendData(this.monthName, this.count);
  final String monthName;
  final double count;
}
