import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../../utils/context_utils.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class NumberPaginator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const NumberPaginator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildArrowButton(
          icon: TablerIcons.chevronLeft,
          onPressed: currentPage > 0
              ? () => onPageChanged(currentPage - 1)
              : null,
        ),
        SizedBox(width: 4.w),
        if (context.isLandscape) ..._buildPageNumbers(),
        SizedBox(width: 4.w),
        _buildArrowButton(
          icon: TablerIcons.chevronRight,
          onPressed: currentPage < totalPages - 1
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }

  Widget _buildArrowButton({required IconData icon, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16.sp,
          color: onPressed == null ? AppColors.grey : AppColors.textBlack,
        ),
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> items = [];
    const int visibleThreshold = 3;

    if (totalPages <= 7) {
      for (int i = 0; i < totalPages; i++) {
        items.add(_buildPageItem(i));
      }
    } else {
      // First page
      items.add(_buildPageItem(0));

      if (currentPage > visibleThreshold) {
        items.add(_buildEllipsis());
      }

      // Pages around current
      int start = (currentPage - 1).clamp(1, totalPages - 2);
      int end = (currentPage + 1).clamp(1, totalPages - 2);

      if (currentPage <= visibleThreshold) {
        start = 1;
        end = 3;
      } else if (currentPage >= totalPages - visibleThreshold - 1) {
        start = totalPages - 4;
        end = totalPages - 2;
      }

      for (int i = start; i <= end; i++) {
        items.add(_buildPageItem(i));
      }

      if (currentPage < totalPages - visibleThreshold - 1) {
        items.add(_buildEllipsis());
      }

      // Last page
      items.add(_buildPageItem(totalPages - 1));
    }

    return items;
  }

  Widget _buildPageItem(int index) {
    bool isSelected = index == currentPage;
    return GestureDetector(
      onTap: () => onPageChanged(index),
      child: Container(
        width: 32.w,
        height: 32.w,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightGrey : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: isSelected ? Border.all(color: AppColors.lightGrey1) : null,
        ),
        child: Text(
          '${index + 1}',
          style: isSelected ? AppFonts.black14w400 : AppFonts.grey14w400,
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text('...', style: AppFonts.grey12w400),
    );
  }
}
