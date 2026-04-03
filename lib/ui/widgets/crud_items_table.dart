import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class CrudItemsTable extends StatelessWidget {
  const CrudItemsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGrey1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Roof', 'Medium 8-12 m2', 'April 15, 2023', true),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Wall Finish', 'Medium 8-12 m2', 'Mar 08, 2023', true),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('R.W.G.', 'Medium 8-12 m2', 'Mar 08, 2023', false),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Hardstanding', 'Medium 8-12 m2', 'April 15, 2023', true),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.sp),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'Item Name',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Material',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Date Added',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String name, String material, String date, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.sp),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(name, style: AppFonts.black14w400)),
          Expanded(flex: 3, child: Text(material, style: AppFonts.black14w400)),
          Expanded(flex: 3, child: Text(date, style: AppFonts.black14w400)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.7,
                  alignment: Alignment.centerLeft,
                  child: Switch(
                    value: isActive,
                    onChanged: (val) {},
                    activeThumbColor: AppColors.white,
                    activeTrackColor: const Color(0xFF32CD32),
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.lightGrey1,
                    trackOutlineColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton(
                  icon: const Icon(Icons.more_horiz, color: AppColors.grey),
                  padding: EdgeInsets.zero,
                  offset: const Offset(0, 40),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            TablerIcons.pencil,
                            size: 16.sp,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8.w),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            TablerIcons.circleMinus,
                            size: 16.sp,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8.w),
                          const Text(
                            'Remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.sp),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF9FF),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add More',
            style: AppFonts.black14w600.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: 4.w),
          Icon(TablerIcons.circlePlus, size: 18.sp, color: AppColors.primary),
        ],
      ),
    );
  }
}
