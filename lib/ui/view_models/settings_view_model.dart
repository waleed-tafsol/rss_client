import '../../utils/enums.dart';

import 'base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsType settingsType = SettingsType.profile;

  void updateSettingsType(SettingsType newSettingsType) {
    settingsType = newSettingsType;
    notifyListeners();
  }
}
