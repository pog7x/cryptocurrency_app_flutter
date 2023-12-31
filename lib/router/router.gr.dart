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
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    CryptoCoinListTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CryptoCoinListTabPage(),
      );
    },
    UserSettingsTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserSettingsTabPage(),
      );
    },
    CryptoCoinSearchTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CryptoCoinSearchTabPage(),
      );
    },
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
    CryptoCoinSearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CryptoCoinSearchScreen(),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CryptoCoinListTabPage]
class CryptoCoinListTab extends PageRouteInfo<void> {
  const CryptoCoinListTab({List<PageRouteInfo>? children})
      : super(
          CryptoCoinListTab.name,
          initialChildren: children,
        );

  static const String name = 'CryptoCoinListTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserSettingsTabPage]
class UserSettingsTab extends PageRouteInfo<void> {
  const UserSettingsTab({List<PageRouteInfo>? children})
      : super(
          UserSettingsTab.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingsTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CryptoCoinSearchTabPage]
class CryptoCoinSearchTab extends PageRouteInfo<void> {
  const CryptoCoinSearchTab({List<PageRouteInfo>? children})
      : super(
          CryptoCoinSearchTab.name,
          initialChildren: children,
        );

  static const String name = 'CryptoCoinSearchTab';

  static const PageInfo<void> page = PageInfo<void>(name);
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

/// generated route for
/// [CryptoCoinSearchScreen]
class CryptoCoinSearchRoute extends PageRouteInfo<void> {
  const CryptoCoinSearchRoute({List<PageRouteInfo>? children})
      : super(
          CryptoCoinSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'CryptoCoinSearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
