import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/dummy/crud_item.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../widgets/app_gradient_button.dart';
import '../widgets/app_secondary_button.dart';
import '../widgets/app_text_field.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class NewCrudScreen extends StatefulWidget {
  const NewCrudScreen._();

  static Future<void> show({required BuildContext context}) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NewCrudScreen._(),

        opaque: false,
      ),
    );
  }

  @override
  State<NewCrudScreen> createState() => _NewCrudScreenState();
}

class _NewCrudScreenState extends State<NewCrudScreen> {
  bool _animated = false;
  final List<CrudItem> _items = [
    CrudItem(
      index: 0,
      itemNameController: TextEditingController(),
      materialController: TextEditingController(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _animated = true;
      });
    });
  }

  void _onAddMoreTap() {
    _items.add(
      CrudItem(
        index: _items.last.index + 1,
        itemNameController: TextEditingController(),
        materialController: TextEditingController(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        setState(() {
          _animated = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withValues(alpha: 0.04),
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _animated
                  ? Matrix4.identity()
                  : Matrix4.translationValues(0.45.sw, 0, 0),
              height: double.infinity,
              width: 0.45.sw,
              padding: EdgeInsets.all(20.w),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('New CRUD', style: AppFonts.black24w600),
                      Divider(height: 48.sp),
                      Expanded(child: _buildBody()),
                      Divider(height: 48.sp),
                      Row(
                        spacing: 12.w,
                        mainAxisAlignment: .end,
                        children: [
                          AppGradientButton(
                            title: 'Add',
                            icon: TablerIcons.plus,
                            onTap: () => Navigator.pop(context),
                          ),
                          AppSecondaryButton(
                            title: 'Cancel',
                            icon: TablerIcons.x,
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const AppTextField(title: 'Name'),
          SizedBox(height: 16.sp),
          _buildMaterialForm(),
          SizedBox(height: 16.sp),
          const AppTextField(title: 'Expected Lifecycle', hint: 'DD/MM/YYYY'),
        ],
      ),
    );
  }

  Container _buildMaterialForm() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11.sp, horizontal: 12.w),
            child: Row(
              spacing: 8.w,
              children: [
                Expanded(child: Text('Item Name', style: AppFonts.black14w400)),
                Expanded(child: Text('Material', style: AppFonts.black14w400)),
              ],
            ),
          ),
          const Divider(height: 0),
          for (final item in _items)
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, top: 6.sp, bottom: 6.sp),
                    child: AppTextField(
                      controller: item.itemNameController,
                      title: 'Item Name',
                      showLabel: false,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 12.w,
                      top: 6.sp,
                      bottom: 6.sp,
                    ),
                    child: AppTextField(
                      controller: item.materialController,
                      title: 'Material Options',
                      showLabel: false,
                    ),
                  ),
                ),
              ],
            ),
          Material(
            child: InkWell(
              onTap: _onAddMoreTap,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
              child: Ink(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8.r),
                  ),
                  color: AppColors.primaryLight,
                ),
                child: Row(
                  spacing: 8.w,
                  children: [
                    Text('Add More', style: AppFonts.primaryDark14w500),
                    Icon(
                      TablerIcons.circlePlus,
                      size: 16.sp,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
