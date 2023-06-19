import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin/abstract_crypto_coin_repository.dart';

part 'crypto_coin_list_event.dart';
part 'crypto_coin_list_state.dart';

class CryptoCoinListBloc
    extends Bloc<CryptoCoinListEvent, CryptoCoinListState> {
  CryptoCoinListBloc(this.cryptoCoinsRepo) : super(CryptoCoinListInitial()) {
    on<LoadCryptoCoinList>(
      (event, emit) async {
        try {
          if (state is! CryptoCoinListLoaded) {
            emit(CryptoCoinListLoading());
          }
          final cryptoCoinList = await cryptoCoinsRepo.getCryptoCoinList('USD');
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
}
