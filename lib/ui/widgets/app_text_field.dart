import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String? Function(String?)? validator;
  final bool showLabel;
  final String? hint;
  const AppTextField({
    super.key,
    this.controller,
    required this.title,
    this.validator,
    this.showLabel = true,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.sp,
      crossAxisAlignment: .start,
      children: [
        if (showLabel) Text(title, style: AppFonts.black14w400),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hint ?? 'Enter $title'),
          validator: validator,
        ),
      ],
    );
  }
}
