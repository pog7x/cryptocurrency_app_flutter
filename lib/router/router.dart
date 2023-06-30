import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:cryptocurrency_app/crypto_coin_app.dart';
import 'package:cryptocurrency_app/features/crypto_coin/crypto_coin.dart';
import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/features/crypto_coin_search/crypto_coin_search.dart';
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
              path: 'home',
              page: CryptoCoinListTab.page,
              children: [
                AutoRoute(
                  path: '',
                  page: CryptoCoinListRoute.page,
                ),
                AutoRoute(
                  path: '',
                  page: CryptoCoinRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'settings',
              page: UserSettingsTab.page,
              children: [
                AutoRoute(
                  path: '',
                  page: UserSettingsRoute.page,
                )
              ],
            ),
            AutoRoute(
              path: 'search',
              page: CryptoCoinSearchTab.page,
              children: [
                AutoRoute(
                  path: '',
                  page: CryptoCoinSearchRoute.page,
                ),
                AutoRoute(
                  path: '',
                  page: CryptoCoinRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}

@RoutePage(name: 'CryptoCoinListTab')
class CryptoCoinListTabPage extends AutoRouter {
  const CryptoCoinListTabPage({super.key});
}

@RoutePage(name: 'UserSettingsTab')
class UserSettingsTabPage extends AutoRouter {
  const UserSettingsTabPage({super.key});
}

@RoutePage(name: 'CryptoCoinSearchTab')
class CryptoCoinSearchTabPage extends AutoRouter {
  const CryptoCoinSearchTabPage({super.key});
}
