import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(this);
  }

    String get toLongDate {
    return DateFormat('MMMM dd, yyyy').format(this);
  }
   String toFormattedDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }
}
