
import '../../utils/enums.dart';
import 'base_view_model.dart';



class SettingsViewModel extends BaseViewModel {
  // SettingsViewModel._() : super(SettingsType.profile);
  SettingsType settingsType = SettingsType.profile;

  void updateSettingsType(SettingsType newSettingsType) {
    if (settingsType == newSettingsType) {
      return;
    }
    settingsType = newSettingsType;
    notifyListeners();
  }
}
