import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import 'property_creation.dart';
import '../../widgets/project_detail_table.dart';
import '../../widgets/status_box.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class ProjectDetail extends StatefulWidget {
  static const String routeName = '/project-detail';
  const ProjectDetail({super.key});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(22.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    TablerIcons.mapPin,
                    color: AppColors.primaryDark,
                    size: 44.sp,
                  ),
                ),
                const SizedBox(width: 12),
                Text("Wandsworth", style: AppFonts.black24w600),
                const Spacer(),
                Row(
                  children: [
                    Text("Active", style: AppFonts.black14w400),
                    SizedBox(width: 8.w),
                    Switch(
                      padding: EdgeInsets.zero,
                      activeTrackColor: AppColors.green,
                      trackOutlineColor: WidgetStatePropertyAll(
                        isActive ? null : AppColors.lightGrey1,
                      ),
                      value: isActive,
                      onChanged: (bool value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 11.sp,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey2,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text("Edit", style: AppFonts.black14w500),
                          SizedBox(width: 4.w),
                          Icon(
                            TablerIcons.pencil,
                            size: 18.sp,
                            color: AppColors.textBlack,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.sp),
          AdaptiveLayoutRowColumn(
            widthBetween: 12.w,
            heightBetween: 12.sp,
            expandedWidget: context.isLandscape ? true : false,
            size: .max,
            children: const [
              const StatusBox(
                title: "Total Properties",
                count: "75",
                icon: TablerIcons.reportSearch,
              ),

              const StatusBox(
                title: "Completed Inspections",
                count: "50",
                icon: TablerIcons.clipboardCheck,
              ),

              const StatusBox(
                title: "Pending Inspections",
                count: "25",
                icon: TablerIcons.report,
              ),
            ],
          ),
          SizedBox(height: 20.sp),
          Container(
            height: 721.sp,
            padding: .all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Properties", style: AppFonts.black18w500),
                    const Spacer(),
                    SizedBox(
                      width: 260.w,
                      height: 43.sp,
                      child: CupertinoSearchTextField(
                        backgroundColor: AppColors.lightGrey2,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      height: 43.sp,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey2,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Assigned Surveyor",
                            style: AppFonts.black14w500,
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 18.sp,
                            color: AppColors.textBlack,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () {
                        context.goNamed(PropertyCreation.routeName);
                      },
                      child: Container(
                        height: 43.sp,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.primaryDark, AppColors.primary],
                          ),

                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Text('New Property', style: AppFonts.white14w500),
                            SizedBox(width: 4.w),
                            Icon(
                              CupertinoIcons.add,
                              size: 18.sp,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      height: 43.sp,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.textBlack,

                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text('Upload CSV', style: AppFonts.white14w500),
                          SizedBox(width: 4.w),
                          Icon(
                            TablerIcons.upload,
                            size: 18.sp,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),
                const Expanded(child: ProjectDetailTable()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
