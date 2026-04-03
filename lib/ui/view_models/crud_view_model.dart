import '../../utils/enums.dart';

import 'base_view_model.dart';

class CrudViewModel extends BaseViewModel {
  CrudType crudType = CrudType.stock;

  void setCrudType(CrudType newCrudType) {
    crudType = newCrudType;
    notifyListeners();
  }
}
