// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Project imports:
import 'package:cryptocurrency_app/crypto_coin_app.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/models/crypto_coin_detail.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';

const cryptoCoinsBoxName = 'crypto_coins_box';

void main() async {
  GetIt.I.registerSingleton(TalkerFlutter.init());

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  Dio dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: GetIt.I<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: GetIt.I<Talker>(),
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  final cryptoCoinRepo = CryptoCoinRepository(dio: dio);
  GetIt.I.registerLazySingleton<AbstractCryptoCoinRepository>(
    () => CachedCryptoCoinRepository(
      repo: cryptoCoinRepo,
      cryptoCoinsBox: cryptoCoinsBox,
    ),
  );

  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };

  runZonedGuarded(
    () => runApp(const CryptoCoinApp()),
    (error, stack) {
      GetIt.I<Talker>().handle(error);
    },
  );
}
