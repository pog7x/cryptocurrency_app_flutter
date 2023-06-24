part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {}

class LoadUserSettings extends UserSettingsEvent {
  @override
  List<Object?> get props => [];
}
