import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

const userSettingsBoxKey = 'user_settings_box_key';

class UserSettingsRepository implements AbstractUserSettingsRepository {
  UserSettingsRepository({
    required this.userSettingsBox,
  });

  final Box<UserSettings> userSettingsBox;

  @override
  UserSettings getUserSettings() {
    var us = const UserSettings();

    try {
      if (userSettingsBox.containsKey(userSettingsBoxKey)) {
        us = userSettingsBox.get(userSettingsBoxKey)!;
      } else {
        userSettingsBox.put(userSettingsBoxKey, us);
      }
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
    }

    return us;
  }

  @override
  UserSettings putUserSettings(UserSettings newUserSettings) {
    try {
      userSettingsBox.put(userSettingsBoxKey, newUserSettings);
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
    }

    return newUserSettings;
  }
}
