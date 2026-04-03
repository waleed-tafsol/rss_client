import 'package:flutter/material.dart';
import '../../utils/enums.dart';
import '../resources/app_fonts.dart';
import '../../utils/inspection_status.dart';

class StatusChip extends StatelessWidget {
  final InspectionStatus status;
  final String? title;
  const StatusChip({super.key, required this.status, this.title});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.only(left: 5),
      avatarBoxConstraints: const BoxConstraints(maxHeight: 6, maxWidth: 6),
      avatar: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: status.fontColor,
          shape: BoxShape.circle,
        ),
      ),
      labelPadding: const EdgeInsets.only(left: 4, right: 5),
      label: Text(
        title ?? status.label,
        style: AppFonts.black12w400.copyWith(color: status.fontColor),
      ),
      backgroundColor: status.backgroundColor,
    );
  }
}
