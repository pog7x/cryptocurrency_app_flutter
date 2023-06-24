import 'package:cryptocurrency_app/models/user_settings.dart';

abstract class AbstractUserSettingsRepository {
  UserSettings getUserSettings();
  UserSettings putUserSettings(UserSettings newUserSettings);
}
