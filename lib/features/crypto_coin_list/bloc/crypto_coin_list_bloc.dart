import 'dart:async';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

part 'crypto_coin_list_event.dart';
part 'crypto_coin_list_state.dart';

const minCryptoLenghtOnListScreen = 15;

class CryptoCoinListBloc
    extends Bloc<CryptoCoinListEvent, CryptoCoinListState> {
  CryptoCoinListBloc(
    this.cryptoCoinsRepo,
    this.userSettingsRepo,
  ) : super(CryptoCoinListInitial()) {
    on<LoadCryptoCoinList>(
      (event, emit) async {
        try {
          if (state is! CryptoCoinListLoaded) {
            emit(CryptoCoinListLoading());
          }
          final userSettings = userSettingsRepo.getUserSettings();
          final cryptoRequest = _calculateCryptoListForRequest(userSettings);
          final cryptoCoinList = await cryptoCoinsRepo.getCryptoCoinList(
            userSettings.favCurrency,
            cryptoRequest,
          );
          emit(CryptoCoinListLoaded(cryptoCoinList: cryptoCoinList));
        } catch (err, stack) {
          emit(CryptoCoinListLoadingError(error: err));
          GetIt.I<Talker>().handle(err, stack);
        } finally {
          event.completer?.complete();
        }
      },
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
    super.onError(error, stackTrace);
  }

  final AbstractCryptoCoinRepository cryptoCoinsRepo;
  final AbstractUserSettingsRepository userSettingsRepo;

  List<String> _calculateCryptoListForRequest(UserSettings userSettings) {
    final toAdd =
        minCryptoLenghtOnListScreen - userSettings.likedCryptocoins.length;

    return toAdd <= 0
        ? userSettings.likedCryptocoins
        : userSettings.likedCryptocoins + allCryptoCoins.sublist(0, toAdd);
  }
}
