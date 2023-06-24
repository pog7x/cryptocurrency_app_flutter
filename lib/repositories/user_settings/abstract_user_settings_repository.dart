import 'package:cryptocurrency_app/models/user_settings.dart';

abstract class AbstractUserSettingsRepository {
  Future<UserSettings> getUserSettings();
  Future<UserSettings> putUserSettings(UserSettings newUserSettings);
}
