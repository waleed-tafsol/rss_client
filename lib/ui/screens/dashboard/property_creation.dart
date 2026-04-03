import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_gradient_button.dart';

class PropertyCreation extends StatefulWidget {
  static const String routeName = '/property-creation';
  const PropertyCreation({super.key});

  @override
  State<PropertyCreation> createState() => _PropertyCreationState();
}

class _PropertyCreationState extends State<PropertyCreation> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final List<bool> _checkedItems = List.generate(
    inspectionList.length,
    (index) => false,
  );
  String? _selectedTenant;
  String? _selectedSurveyor;

  static const inspectionList = [
    "Stock",
    "Attributes",
    "Windows",
    "D&M Survey",
    "Repairs",
    "HHSRS",
  ];
  static const List<String> teintierOptions = [
    'option 1',
    'option 2',
    'option 3',
  ];
  static const List<String> surveyorOptions = [
    'option 1',
    'option 2',
    'option 3',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPropertyCreationForm(),
          SizedBox(height: 20.w),
          _buildtenantAndSurveryorRow(),
          SizedBox(height: 20.w),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: context.isLandscape
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text("Inspection Checklist", style: AppFonts.black18w500),
                SizedBox(height: 16.w),
                Row(
                  mainAxisAlignment: context.isLandscape
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: context.isLandscape
                            ? WrapAlignment.start
                            : WrapAlignment.center,
                        spacing: 8.w,
                        runSpacing: 8.w,
                        children: List.generate(
                          inspectionList.length,
                          (index) => _buildInspectionChecklist(
                            title: inspectionList[index],
                            isChecked: _checkedItems[index],
                            index: index,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.w),
                AdaptiveLayoutRowColumn(
                  widthBetween: 12.w,
                  heightBetween: 12.w,

                  children: [
                    const AppGradientButton(
                      title: 'Create',
                      icon: TablerIcons.check,
                    ),

                    Container(
                      padding:  EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 11.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey2,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cancel", style: AppFonts.black14w500),
                          SizedBox(width: 4.w),
                           Icon(
                            TablerIcons.x,
                            size: 24.sp,
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
        ],
      ),
    );
  }

  Widget _buildPropertyCreationForm() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Property Details", style: AppFonts.black18w500),
          SizedBox(height: 16.w),
          Text("UPRN", style: AppFonts.black14w400),
          SizedBox(height: 12.w),
          const TextField(decoration: InputDecoration(hintText: 'Enter UPRN')),
          SizedBox(height: 16.w),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date", style: AppFonts.black14w400),
                    SizedBox(height: 12.w),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Post Code", style: AppFonts.black14w400),
                    SizedBox(height: 12.w),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Post Code'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Town", style: AppFonts.black14w400),
                    SizedBox(height: 12.w),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Town'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Year Build", style: AppFonts.black14w400),
                    SizedBox(height: 12.w),
                    TextField(
                      controller: _yearController,
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
                            _yearController.text =
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
            ],
          ),
          SizedBox(height: 16.w),
          Text("Property Type", style: AppFonts.black14w400),
          SizedBox(height: 12.w),
          const TextField(
            decoration: InputDecoration(hintText: 'Select Property Type'),
          ),
          SizedBox(height: 16.w),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address 1", style: AppFonts.black14w400),
                     SizedBox(height: 12.w),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Address 1'),
                    ),
                  ],
                ),
              ),
               SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address 2", style: AppFonts.black14w400),
                     SizedBox(height: 12.w),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Address 2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildtenantAndSurveryorRow() {
    return AdaptiveLayoutRowColumn(
      widthBetween: 20.w,
      heightBetween: 20.w,
      expandedWidget: context.isLandscape ? true : false,
      children: [
        Container(
          width: double.infinity,
          padding:  EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: context.isLandscape
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text("Tenant Details", style: AppFonts.black18w500),
              SizedBox(height: 16.w),
              Text("Tenant", style: AppFonts.black14w400),
              SizedBox(height: 12.w),

              AppDropdown<String>(
                hint: "Select Tenant",
                value: _selectedTenant,
                builder: (item) => Text(item),
                items: teintierOptions,
                onChanged: (value) {
                  setState(() => _selectedTenant = value);
                },
              ),
              SizedBox(height: 16.w),
              Container(
                padding:  EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.fillColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.lightGrey2),
                ),
                child: AdaptiveLayoutRowColumn(
                  widthBetween: 12.w,
                  heightBetween: 12.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  alignment: .center,
                  children: [
                     CircleAvatar(
                      radius: 32.r,
                      backgroundColor: AppColors.lightGrey1,
                      backgroundImage: const NetworkImage(
                        'https://picsum.photos/400/400',
                      ),
                    ),

                    Column(
                      crossAxisAlignment: context.isLandscape
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text("George Michael", style: AppFonts.black18w500),
                        SizedBox(height: 8.w),
                        AdaptiveLayoutRowColumn(
                          widthBetween: 12.w,
                          heightBetween: 12.w,
                          alignment: context.isLandscape
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: context.isLandscape
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                 Icon(
                                  TablerIcons.mail,
                                  size: 16.sp,
                                  color: AppColors.textBlack,
                                ),
                                 SizedBox(width: 10.w),
                                Text(
                                  "michael@gmail.com",
                                  style: AppFonts.black14w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: context.isLandscape
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                 Icon(
                                  TablerIcons.phone,
                                  size: 16.sp,
                                  color: AppColors.textBlack,
                                ),
                                 SizedBox(width: 10.w),
                                Text(
                                  "+1 234 567 890",
                                  style: AppFonts.black14w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.isLandscape
                        ? const Spacer()
                        : const SizedBox.shrink(),
                    Container(
                      padding:  EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child:  Icon(
                        TablerIcons.circleMinus,
                        size: 24.sp,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double
              .infinity, // Ensures the container takes the full available width
          padding:  EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: context.isLandscape
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text("Assigned Surveyor", style: AppFonts.black18w500),
              SizedBox(height: 16.w),
              Text("Surveyor", style: AppFonts.black14w400),
               SizedBox(height: 12.w),
              AppDropdown<String>(
                hint: "Select Surveyor",
                builder: (item) => Text(item),
                value: _selectedSurveyor,
                items: surveyorOptions,
                onChanged: (value) {
                  setState(() => _selectedSurveyor = value);
                },
              ),
              SizedBox(height: 16.w),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.fillColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.lightGrey2),
                ),
                child: AdaptiveLayoutRowColumn(
                  widthBetween: 12.w,
                  heightBetween: 12.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  alignment: .center,
                  children: [
                     CircleAvatar(
                      radius: 32.r,
                      backgroundColor: AppColors.lightGrey1,
                      backgroundImage: const NetworkImage(
                        "https://picsum.photos/400/400",
                      ),
                    ),

                    Column(
                      crossAxisAlignment: context.isLandscape
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text("Michael Smith", style: AppFonts.black18w500),
                         SizedBox(height: 8.w),
                        AdaptiveLayoutRowColumn(
                          widthBetween: 12.w,
                          heightBetween: 12.w,
                          alignment: context.isLandscape
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: context.isLandscape
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                 Icon(
                                  TablerIcons.mail,
                                  size: 16.sp,
                                  color: AppColors.textBlack,
                                ),
                                 SizedBox(width: 10.w),
                                Text(
                                  "michael@gmail.com",
                                  style: AppFonts.black14w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: context.isLandscape
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                 Icon(
                                  TablerIcons.phone,
                                  size: 16.sp,
                                  color: AppColors.textBlack,
                                ),
                                 SizedBox(width: 10.w),
                                Text(
                                  "+1 234 567 890",
                                  style: AppFonts.black14w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.isLandscape
                        ? const Spacer()
                        : const SizedBox.shrink(),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child:  Icon(
                        TablerIcons.circleMinus,
                        size: 24.sp,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildInspectionChecklist({
    required String title,
    required bool isChecked,
    required int index,
  }) {
    return Container(
      width: 345.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGrey2),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4),

            onPressed: () {
              setState(() {
                _checkedItems[index] =
                    !_checkedItems[index]; // Toggle the state for the selected item
              });
            },
            icon: Icon(
              isChecked ? Icons.check_circle : Icons.circle_outlined,
              size: 16,
              color: isChecked ? AppColors.primaryDark : AppColors.textBlack,
            ),
          ),
          Text(title, style: AppFonts.black18w500),
        ],
      ),
    );
  }
}
