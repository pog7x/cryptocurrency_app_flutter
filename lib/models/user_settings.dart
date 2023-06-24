import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cryptocurrency_app/models/constants.dart';

part 'user_settings.g.dart';

@HiveType(typeId: userSettingsHiveTypeID)
class UserSettings extends Equatable {
  const UserSettings({
    this.favCurrency = 'EUR',
    this.appThemeMode = 'System',
    this.likedCryptocoins = const <String>[],
  });

  @HiveField(0)
  final String favCurrency;

  @HiveField(1)
  final String appThemeMode;

  @HiveField(2)
  final List<String> likedCryptocoins;

  @override
  List<Object?> get props => [
        favCurrency,
        appThemeMode,
        likedCryptocoins,
      ];
}
