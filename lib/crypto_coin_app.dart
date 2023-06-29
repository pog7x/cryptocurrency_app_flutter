import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/router/router.dart';
import 'package:cryptocurrency_app/ui/themes/themes.dart';

class CryptoCoinApp extends StatefulWidget {
  const CryptoCoinApp({super.key});

  @override
  State<CryptoCoinApp> createState() => _CryptoCoinAppState();
}

class _CryptoCoinAppState extends State<CryptoCoinApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My best crypto coin application',
      theme: lightTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
    );
  }
}

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      animatePageTransition: false,
      routes: const [
        CryptoCoinListRoute(),
        UserSettingsRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: SalomonBottomBar(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: [
              SalomonBottomBarItem(
                unselectedColor: Colors.grey,
                selectedColor: Colors.yellow,
                icon: const Icon(
                  Icons.home,
                  size: 20,
                ),
                title: const Text('Home'),
              ),
              SalomonBottomBarItem(
                unselectedColor: Colors.grey,
                selectedColor: Colors.yellow,
                icon: const Icon(
                  Icons.settings,
                  size: 20,
                ),
                title: const Text('Settings'),
              )
            ],
          ),
        );
      },
    );
  }
}
