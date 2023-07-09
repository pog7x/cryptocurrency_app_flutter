import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/crypto_coin_app.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/models/crypto_coin_detail.dart';
import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

const cryptoCoinsBoxName = 'crypto_coins_box';
const userSettingsBoxName = 'user_settings_box';
const likedCryptoCoinsBoxName = 'liked_crypto_coins_box';

void main() async {
  GetIt.I.registerSingleton(TalkerFlutter.init());

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());
  Hive.registerAdapter(UserSettingsAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);
  final userSettingsBox = await Hive.openBox<UserSettings>(userSettingsBoxName);
  final likedCryptoCoinsBox = await Hive.openBox<List<String>>(
    likedCryptoCoinsBoxName,
  );

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

  GetIt.I.registerLazySingleton<AbstractUserSettingsRepository>(
    () => UserSettingsRepository(
      userSettingsBox: userSettingsBox,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractLikedCryptoCoinsRepository>(
    () => LikedCryptoCoinsRepository(
      likedCryptoCoinsBox: likedCryptoCoinsBox,
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
