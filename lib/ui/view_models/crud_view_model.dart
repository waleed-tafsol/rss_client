
import '../../utils/enums.dart';
import 'base_view_model.dart';

class CrudViewModel extends BaseViewModel {
  // CrudViewModel._() : super(CrudType.stock);
  CrudType crudType = CrudType.stock;
  void setCrudType(CrudType newCrudType) {
    if (crudType == newCrudType) {
      return;
    }
    crudType = newCrudType;
    notifyListeners();
  }
}
