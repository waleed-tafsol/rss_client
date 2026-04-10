import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import 'app_gradient_button.dart';

class ImageSelectionDialog {
  static Future<String?> show({
    required BuildContext context,
    String? title,
  }) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ImageSelectionDialogContent(title: title ?? 'Select Image');
      },
    );
  }
}

class ImageSelectionDialogContent extends StatefulWidget {
  final String title;

  const ImageSelectionDialogContent({super.key, required this.title});

  @override
  State<ImageSelectionDialogContent> createState() =>
      _ImageSelectionDialogContentState();
}

class _ImageSelectionDialogContentState
    extends State<ImageSelectionDialogContent> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        Navigator.of(context).pop(image.path);
      }
    } catch (e, s) {
      log('Error picking image: $e', stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: AppFonts.black16w500),
              SizedBox(height: 20.h),

              _buildOption(
                icon: Icons.photo_library,
                title: 'Gallery',
                subtitle: 'Choose from gallery',
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),

              SizedBox(height: 20.h),

              AppGradientButton(
                title: "Cancel",
                icon: TablerIcons.x,
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 1.sp),
        ),
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(title, style: AppFonts.black16w500),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: AppFonts.black12w400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
