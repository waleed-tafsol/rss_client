import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../view_models/auth_view_model.dart';
import 'app_gradient_button.dart';
import 'app_loader.dart';
import 'app_network_image.dart';
import 'app_secondary_button.dart';
import 'app_text_field.dart';
import 'image_selection_dailog_box.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String? image;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authVM = context.read<AuthViewModel>();
      fullNameController.text = authVM.user?.name ?? '';
      emailController.text = authVM.user?.email ?? '';
      contactNumberController.text = authVM.user?.profile?.contactNumber ?? '';
      image = authVM.user?.profile?.profileImage;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        return Column(
          crossAxisAlignment: .stretch,
          children: [
            Row(
              spacing: 24.w,
              children: [
                ClipOval(
                  child: authVM.profileImage != null
                      ? (kIsWeb
                            ? Image.network(
                                authVM.profileImage?.path ?? "",
                                width: 120.w,
                                height: 120.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    TablerIcons.userCircle,
                                    size: 64.w,
                                    color: AppColors.textBlack,
                                  );
                                },
                              )
                            : Image.file(
                                File(authVM.profileImage?.path ?? ""),
                                width: 120.w,
                                height: 120.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    TablerIcons.userCircle,
                                    size: 64.w,
                                    color: AppColors.textBlack,
                                  );
                                },
                              ))
                      : AppNetworkImage(
                          imageUrl: image ?? "",
                          width: 120.w,
                          height: 120.w,
                        ),
                ),
                Column(
                  spacing: 8.sp,
                  children: [
                    AppSecondaryButton(
                      title: 'Upload an Image',
                      icon: TablerIcons.upload,
                      onTap: () async {
                        final imagePath = await ImageSelectionDialog.show(
                          context: context,
                          title: 'Select Profile Image',
                        );
                        if (mounted) {
                          authVM.updateProfileImage(imagePath);
                        }
                      },
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
            Divider(height: 32.sp),
            Text('Basic Details', style: AppFonts.black18w500),
            SizedBox(height: 16.sp),
            Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: fullNameController,
                    title: 'Full Name',
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    controller: emailController,
                    readOnly: true,
                    title: 'Email',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.sp),
            AppTextField(
              controller: contactNumberController,
              title: 'Contact Number',
            ),
            SizedBox(height: 16.sp),
            Row(
              spacing: 12.w,
              children: [
                Consumer<AuthViewModel>(
                  builder: (context, authVM, _) {
                    if (authVM.loading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const AppLoader(),
                      );
                    }
                    return AppGradientButton(
                      title: 'Save Changes',
                      icon: TablerIcons.check,
                      onTap: () {
                        context.read<AuthViewModel>().updateProfile(
                          name: fullNameController.text,
                          phone: contactNumberController.text,
                        );
                      },
                    );
                  },
                ),
                AppSecondaryButton(
                  title: 'Cancel',
                  icon: TablerIcons.x,
                  onTap: () {
                    fullNameController.text = authVM.user?.name ?? '';
                    emailController.text = authVM.user?.email ?? '';
                    contactNumberController.text =
                        authVM.user?.profile?.contactNumber ?? '';
                    image = authVM.user?.profile?.profileImage;
                    if (mounted) {
                      authVM.updateProfileImage(null);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
