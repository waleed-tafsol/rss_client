import '../../utils/enums.dart';
import 'base_view_model.dart';

class CrudViewModel extends BaseViewModel {
  CrudType _crudType = CrudType.stock;

  CrudType get crudType => _crudType;

  void setCrudType(CrudType newCrudType) {
    if (_crudType == newCrudType) {
      return;
    }
    _crudType = newCrudType;
    notifyListeners();
  }
}
