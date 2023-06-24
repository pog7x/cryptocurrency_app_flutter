import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc(this.userSettingsRepo) : super(UserSettingsInitial()) {
    on<LoadUserSettings>(
      (event, emit) async {
        try {
          if (state is! UserSettingsLoaded) {
            emit(UserSettingsLoading());
          }
          final us = await userSettingsRepo.getUserSettings();
          emit(UserSettingsLoaded(userSettings: us));
        } catch (err, stack) {
          emit(UserSettingsLoadingError(error: err));
          GetIt.I<Talker>().handle(err, stack);
        }
      },
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
    super.onError(error, stackTrace);
  }

  final AbstractUserSettingsRepository userSettingsRepo;
}
