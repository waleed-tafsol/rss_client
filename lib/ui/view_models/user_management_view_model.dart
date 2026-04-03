import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/enums.dart';
import 'base_view_model.dart';

final userManagementProvider = NotifierProvider.autoDispose(
  () => UserManagementViewModel._(),
);

class UserManagementViewModel extends BaseViewModel<UserType> {
  UserManagementViewModel._() : super(UserType.surveyors);

  void changeUserType(UserType newUserType) {
    if (newUserType == state) {
      return;
    }
    state = UserType.surveyors;
  }
}
