// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Project imports:
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.cryptoCoinsRepo) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>(
      (event, emit) async {
        try {
          if (state is! CryptoCoinLoaded) {
            emit(CryptoCoinLoading());
          }
          final coinDetail = await cryptoCoinsRepo.cryptoCoinDetail(
            'USD',
            event.cryptoCoin.name,
          );
          emit(CryptoCoinLoaded(cryptoCoin: coinDetail));
        } catch (err, stack) {
          emit(CryptoCoinLoadingError(error: err));
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
}
