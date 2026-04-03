import '../../utils/enums.dart';

import 'base_view_model.dart';

class UserManagementViewModel extends BaseViewModel {
  UserType userType = UserType.surveyors;

  void changeUserType(UserType newUserType) {
    userType = newUserType;
    notifyListeners();
  }
}
