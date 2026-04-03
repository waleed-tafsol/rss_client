import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_gradient_button.dart';
import '../../widgets/app_secondary_button.dart';
import '../../widgets/app_text_field.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class SurveryorUpdate extends StatefulWidget {
  static const String routeName = '/surveryor-update';
  const SurveryorUpdate({super.key});

  @override
  State<SurveryorUpdate> createState() => _SurveryorUpdateState();
}

class _SurveryorUpdateState extends State<SurveryorUpdate> {
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        // expandedWidget: context.isLandscape ? false : true,
        crossAxisAlignment: .start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaptiveLayoutRowColumn(
            expandedWidget: context.isLandscape ? false : true,
            heightBetween: 24.w,
            children: [
              Container(
                padding: .all(28.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGrey2,
                ),
                child: Icon(
                  TablerIcons.userCircle,
                  size: 64.w,
                  color: AppColors.textBlack,
                ),
              ),
              Column(
                spacing: 8.h,
                children: [
                  const AppSecondaryButton(
                    title: 'Upload an Image',
                    icon: TablerIcons.upload,
                  ),
                  Text(
                    'Allowed jpeg, jpg, png \nMax size of 4.00 MB',
                    style: AppFonts.grey12w400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 32.h),
          Text('Basic Details', style: AppFonts.black18w500),
          SizedBox(height: 16.h),
          Row(
            spacing: 16.w,
            children: const [
              Expanded(child: AppTextField(title: 'Full Name')),
              Expanded(child: AppTextField(title: 'Email')),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date of Birth", style: AppFonts.black14w400),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: _dateController,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          // Update the TextField with the selected date
                          setState(() {
                            _dateController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'DD/MM/YYYY',
                        suffixIcon: Icon(
                          TablerIcons.calendar,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              const Expanded(child: AppTextField(title: 'Contact Number')),
            ],
          ),
          SizedBox(height: 16.h),
          const AppTextField(title: 'Address'),
          SizedBox(height: 16.h),
          Row(
            spacing: 12.w,
            children: const [
              AppGradientButton(title: 'Update', icon: TablerIcons.check),
              AppSecondaryButton(title: 'Cancel', icon: TablerIcons.x),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomExpanded extends StatelessWidget {
  const CustomExpanded({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return context.isLandscape ? Expanded(child: child) : child;
  }
}

class CustomScrollView extends StatelessWidget {
  const CustomScrollView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return context.isLandscape ? SingleChildScrollView(child: child) : child;
  }
}
