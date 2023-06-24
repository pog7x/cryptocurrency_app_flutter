// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    UserSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserSettingsScreen(),
      );
    },
    CryptoCoinRoute.name: (routeData) {
      final args = routeData.argsAs<CryptoCoinRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CryptoCoinScreen(
          key: args.key,
          cryptoCoin: args.cryptoCoin,
        ),
      );
    },
    CryptoCoinListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CryptoCoinListScreen(),
      );
    },
  };
}

/// generated route for
/// [UserSettingsScreen]
class UserSettingsRoute extends PageRouteInfo<void> {
  const UserSettingsRoute({List<PageRouteInfo>? children})
      : super(
          UserSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CryptoCoinScreen]
class CryptoCoinRoute extends PageRouteInfo<CryptoCoinRouteArgs> {
  CryptoCoinRoute({
    Key? key,
    required CryptoCoin cryptoCoin,
    List<PageRouteInfo>? children,
  }) : super(
          CryptoCoinRoute.name,
          args: CryptoCoinRouteArgs(
            key: key,
            cryptoCoin: cryptoCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'CryptoCoinRoute';

  static const PageInfo<CryptoCoinRouteArgs> page =
      PageInfo<CryptoCoinRouteArgs>(name);
}

class CryptoCoinRouteArgs {
  const CryptoCoinRouteArgs({
    this.key,
    required this.cryptoCoin,
  });

  final Key? key;

  final CryptoCoin cryptoCoin;

  @override
  String toString() {
    return 'CryptoCoinRouteArgs{key: $key, cryptoCoin: $cryptoCoin}';
  }
}

/// generated route for
/// [CryptoCoinListScreen]
class CryptoCoinListRoute extends PageRouteInfo<void> {
  const CryptoCoinListRoute({List<PageRouteInfo>? children})
      : super(
          CryptoCoinListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CryptoCoinListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
