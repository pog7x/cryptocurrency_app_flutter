import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

part 'crypto_coin_list_event.dart';
part 'crypto_coin_list_state.dart';

const minCryptoLenghtOnListScreen = 15;

class CryptoCoinListBloc
    extends Bloc<CryptoCoinListEvent, CryptoCoinListState> {
  CryptoCoinListBloc(
    this.cryptoCoinsRepo,
    this.userSettingsRepo,
    this.likedCryptoCoinsRepo,
  ) : super(CryptoCoinListInitial()) {
    on<LoadCryptoCoinList>(
      (event, emit) async {
        try {
          if (state is! CryptoCoinListLoaded) {
            emit(CryptoCoinListLoading());
          }
          final liked = likedCryptoCoinsRepo.getLikedCryptoCoins();
          final userSettings = userSettingsRepo.getUserSettings();
          final cryptoRequest = _calculateCryptoListForRequest(liked);
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

  final AbstractCryptoCoinRepository cryptoCoinsRepo;
  final AbstractUserSettingsRepository userSettingsRepo;
  final AbstractLikedCryptoCoinsRepository likedCryptoCoinsRepo;

  @override
  void onError(Object error, StackTrace stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
    super.onError(error, stackTrace);
  }

  List<String> _calculateCryptoListForRequest(List<String> likedCryptocoins) {
    final toAdd = minCryptoLenghtOnListScreen - likedCryptocoins.length;

    return toAdd <= 0
        ? likedCryptocoins
        : likedCryptocoins + allCryptoCoins.sublist(0, toAdd);
  }
}
