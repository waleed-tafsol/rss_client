import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/enums.dart';
import 'base_view_model.dart';

final settingsProvider = NotifierProvider.autoDispose(
  () => SettingsViewModel._(),
);

class SettingsViewModel extends BaseViewModel<SettingsType> {
  SettingsViewModel._() : super(SettingsType.profile);

  void updateSettingsType(SettingsType newSettingsType) {
    if (state == newSettingsType) {
      return;
    }
    state = newSettingsType;
  }
}
