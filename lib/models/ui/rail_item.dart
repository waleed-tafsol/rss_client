import 'package:flutter/cupertino.dart';

class RailItem {
  final String label;
  final IconData icon;
  final String routeName;

  const RailItem({
    required this.label,
    required this.icon,
    required this.routeName,
  });
}
