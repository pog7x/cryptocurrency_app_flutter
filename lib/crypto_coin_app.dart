// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Project imports:
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
