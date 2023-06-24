part of 'user_settings_bloc.dart';

abstract class UserSettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSettingsInitial extends UserSettingsState {}

class UserSettingsLoading extends UserSettingsState {}

class UserSettingsLoaded extends UserSettingsState {
  UserSettingsLoaded({
    required this.userSettings,
  });

  final UserSettings userSettings;

  @override
  List<Object?> get props => [userSettings];
}

class UserSettingsLoadingError extends UserSettingsState {
  UserSettingsLoadingError({
    required this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
