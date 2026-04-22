import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../resources/app_colors.dart';
import '../view_models/auth_view_model.dart';

class PhoneWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueSetter<String>? onChanged;

  final bool showLabel;
  final bool filled;
  final bool removeValidation;
  final bool isEditable;

  PhoneWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.isEditable = false,

    this.showLabel = true,
    this.filled = false,
    this.removeValidation = false,
  });

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        TextFormField(
          readOnly: isEditable,
          // enabled: isEditable,
          controller: controller,
          // focusNode: _focusNode,
          onChanged: onChanged,
          autofocus: false,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            } else if (value.length < 10) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontFamily: "General Sans"),
          onTapOutside: (_) {
            _focusNode.unfocus();
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: filled,
            fillColor: AppColors.textBlack,
            hintText: '921 - 2341 -99908',
            // hintStyle:
            //     Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(
            //           // color: Colors.amber
            //           fontFamily: "General Sans",
            //         ),
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,

              color: Colors.grey,
            ),
            prefixIcon: _buildPhoneNumberPicker(context: context),
          ),
        ),
      ],
    );
  }

  IntrinsicHeight _buildPhoneNumberPicker({required BuildContext context}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {},

            child: Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                // final country = authVM.country;
                return CountryCodePicker(
                  onChanged: (country) {
                    authVM.setCountry(country);
                  },
                  dialogSize: Size(400.w, 600.w),
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,

                    color: AppColors.textBlack,
                  ),

                  
                  initialSelection: authVM.country?.code ?? "GB",

                
                  showCountryOnly: false,
                 
                  showOnlyCountryWhenClosed: false,
                  
                  alignLeft: false,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.3.h),
            child: const VerticalDivider(
              color: Color(0xffE2E5E8),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
