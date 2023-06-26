import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:cryptocurrency_app/features/crypto_coin/crypto_coin.dart';
import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/features/user_settings/user_settings.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoCoinListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
        AutoRoute(page: UserSettingsRoute.page),
      ];
}
