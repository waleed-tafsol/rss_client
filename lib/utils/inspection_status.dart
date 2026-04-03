import 'dart:ui';

import '../ui/resources/app_colors.dart';
import 'enums.dart';

extension InspectionStatusExtension on InspectionStatus {
  String get label {
    switch (this) {
      case InspectionStatus.inProgress:
        return 'In Progress';
      case InspectionStatus.upcoming:
        return 'Upcoming';
      case InspectionStatus.completed:
        return 'Completed';
    }
  }

  Color get fontColor {
    switch (this) {
      case InspectionStatus.inProgress:
        return AppColors.blue;
      case InspectionStatus.upcoming:
        return AppColors.yellow;
      case InspectionStatus.completed:
        return AppColors.darkGreen;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case InspectionStatus.inProgress:
        return AppColors.lightBlue.withValues(alpha: 0.2);
      case InspectionStatus.upcoming:
        return AppColors.lightYellow;
      case InspectionStatus.completed:
        return AppColors.lightGreen;

    }
  }
}
