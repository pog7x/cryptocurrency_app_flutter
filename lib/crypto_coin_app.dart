import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/generated/l10n.dart';
import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:cryptocurrency_app/router/router.dart';
import 'package:cryptocurrency_app/ui/themes.dart';

class CryptoCoinApp extends StatefulWidget {
  const CryptoCoinApp({super.key, required this.userSettingsBox});

  final Box<UserSettings> userSettingsBox;

  @override
  State<CryptoCoinApp> createState() => _CryptoCoinAppState();
}

class _CryptoCoinAppState extends State<CryptoCoinApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserSettings>>(
      valueListenable: widget.userSettingsBox.listenable(),
      builder: (BuildContext context, Box<UserSettings> box, Widget? child) {
        var us = const UserSettings();
        var themeMode = ThemeMode.system;

        try {
          if (box.containsKey(userSettingsBoxKey)) {
            us = box.get(userSettingsBoxKey)!;
          }
        } catch (err, stack) {
          GetIt.I<Talker>().handle(err, stack);
        }

        switch (us.appThemeMode) {
          case appThemeModeDark:
            themeMode = ThemeMode.dark;
            break;
          case appThemeModeLight:
            themeMode = ThemeMode.light;
            break;
          default:
            themeMode = ThemeMode.system;
        }

        return MaterialApp.router(
          title: 'Cryptocurrencies',
          onGenerateTitle: (context) => S.of(context).cryptocurrencies,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(us.userLocale),
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: _appRouter.config(
            navigatorObservers: () => [
              TalkerRouteObserver(GetIt.I<Talker>()),
            ],
          ),
        );
      },
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
        CryptoCoinSearchRoute(),
        UserSettingsRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: S.of(context).home,
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: S.of(context).search,
                icon: const Icon(Icons.search),
                activeIcon: const Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: S.of(context).settings,
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings),
              )
            ],
          ),
        );
      },
    );
  }
}
