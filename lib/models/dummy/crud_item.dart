import 'package:flutter/cupertino.dart';

class CrudItem {
  final int index;
  final TextEditingController itemNameController;
  final TextEditingController materialController;

  const CrudItem({
    required this.index,
    required this.itemNameController,
    required this.materialController,
  });
}
