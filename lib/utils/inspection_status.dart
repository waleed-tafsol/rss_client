import 'dart:ui';

import '../ui/resources/app_colors.dart';
import 'enums.dart';

extension StatusExtension on Status {
  String get label {
    switch (this) {
      case Status.inprogress:
        return 'In Progress';
      case Status.upcoming:
        return 'UpComing';
      case Status.completed:
        return 'Completed';
    }
  }

  Color get fontColor {
    switch (this) {
      case Status.inprogress:
        return AppColors.blue;
      case Status.upcoming:
        return AppColors.yellow;
      case Status.completed:
        return AppColors.darkGreen;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case Status.inprogress:
        return AppColors.lightBlue.withValues(alpha: 0.2);
      case Status.upcoming:
        return AppColors.lightYellow;
      case Status.completed:
        return AppColors.lightGreen;

    }
  }
}
