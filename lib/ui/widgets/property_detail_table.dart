import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class PropertyDetailItemsTable extends StatelessWidget {
  const PropertyDetailItemsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGrey1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Roof', 'Medium 8-12 m2'),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Wall Finish', 'Medium 8-12 m2'),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('R.W.G.', 'Medium 8-12 m2'),
          const Divider(height: 1, color: AppColors.lightGrey1),
          _buildRow('Hardstanding', 'Medium 8-12 m2'),
          const Divider(height: 1, color: AppColors.lightGrey1),
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
              'Area Size',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              '',
              style: AppFonts.grey12w400.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String name, String material) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.sp),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(name, style: AppFonts.black14w400)),
          Expanded(flex: 3, child: Text(material, style: AppFonts.black14w400)),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,

              child: PopupMenuButton(
                icon: const Icon(Icons.more_horiz, color: AppColors.grey),
                padding: EdgeInsets.zero,
                offset: const Offset(0, 40),
                itemBuilder: (context) => [
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
            ),
          ),
        ],
      ),
    );
  }
}
