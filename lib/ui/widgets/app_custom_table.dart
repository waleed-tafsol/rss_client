import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class AppCustomTable extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final List<double> flexValues;
  final bool fixedSpan;
  final double? rowHeight;
  final bool scrollableX, scrollableY;

  const AppCustomTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.flexValues,
    this.fixedSpan = false,
    this.rowHeight,
    this.scrollableX = true,
    this.scrollableY = false,
  });

  @override
  Widget build(BuildContext context) {
    final double totalFlex = flexValues.fold(0, (sum, flex) => sum + flex);
    final double headerHeight = 43.sp;
    final double rowHeight = this.rowHeight ?? 43.sp;
    final double totalHeight =
        headerHeight + (rows.length * rowHeight) + (rows.length * 25.h);

    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGrey1),
      ),
      child: TableView.builder(
        columnCount: columns.length,
        rowCount: rows.length + 1,
        verticalDetails: ScrollableDetails(
          direction: AxisDirection.down,
          physics: scrollableY ? null : const NeverScrollableScrollPhysics(),
        ),
        horizontalDetails: ScrollableDetails(
          direction: AxisDirection.right,
          physics: scrollableX ? null : const NeverScrollableScrollPhysics(),
        ),
        columnBuilder: (index) => TableSpan(
          extent: fixedSpan
              ? FixedSpanExtent(flexValues[index])
              : FractionalTableSpanExtent(flexValues[index] / totalFlex),
        ),
        rowBuilder: (index) => TableSpan(
          extent: FixedTableSpanExtent(index == 0 ? headerHeight : rowHeight),
          foregroundDecoration: TableSpanDecoration(
            border: TableSpanBorder(
              trailing: index == 0
                  ? const BorderSide(color: AppColors.lightGrey1)
                  : BorderSide.none,
            ),
          ),
          padding: SpanPadding(trailing: 5.w, leading: 5.w),
        ),
        cellBuilder: (context, vicinity) {
          if (vicinity.row == 0) {
            return TableViewCell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    columns[vicinity.column],
                    style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
                  ),
                ),
              ),
            );
          }

          return TableViewCell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: rows[vicinity.row - 1][vicinity.column],
              ),
            ),
          );
        },
      ),
    );
  }
}
