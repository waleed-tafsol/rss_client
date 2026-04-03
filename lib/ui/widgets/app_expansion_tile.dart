import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_fonts.dart';
import 'crud_items_table.dart';

class AppExpansionTile extends StatelessWidget {
  final String title;
  final Widget? child;
  final List<Widget> actions;
  const AppExpansionTile({
    super.key,
    required this.title,
    this.child,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      minTileHeight: 0,
      dense: true,
      childrenPadding: EdgeInsets.all(16.w),
      visualDensity: VisualDensity.compact,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppFonts.black16w500),
          SizedBox(width: 12.w),
          ...actions,
        ],
      ),
      children: [if (child != null) child! else const CrudItemsTable()],
    );
  }
}
