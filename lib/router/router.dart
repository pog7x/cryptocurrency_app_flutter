import 'package:cryptocurrency_app/crypto_coin_app.dart';
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
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              path: 'list',
              page: CryptoCoinListRoute.page,
            ),
            AutoRoute(
              path: 'settings',
              page: UserSettingsRoute.page,
            ),
          ],
        ),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}
