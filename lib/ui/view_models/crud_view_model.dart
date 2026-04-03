import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/enums.dart';
import 'base_view_model.dart';

final crudProvider = NotifierProvider.autoDispose(() => CrudViewModel._());

class CrudViewModel extends BaseViewModel<CrudType> {
  CrudViewModel._() : super(CrudType.stock);

  void setCrudType(CrudType newCrudType) {
    if (state == newCrudType) {
      return;
    }
    state = newCrudType;
  }
}
