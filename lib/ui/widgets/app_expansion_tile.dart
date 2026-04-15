import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_fonts.dart';
import 'crud_items_table.dart';

class AppExpansionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? child, leading;
  final List<Widget> actions;
  const AppExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.leading,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      minTileHeight: 0,
      dense: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      visualDensity: VisualDensity.compact,
      leading: leading,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) SizedBox(width: 24.w),
          Text(title, style: AppFonts.black16w500),
          SizedBox(width: 12.w),
          ...actions,
        ],
      ),
      subtitle: subtitle != null
          ? Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(subtitle!, style: AppFonts.grey14w400),
            )
          : null,
      children: [if (child != null) child! else const CrudItemsTable()],
    );
  }
}
