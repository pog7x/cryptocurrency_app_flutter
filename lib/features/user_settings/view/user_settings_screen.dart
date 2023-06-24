import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/user_settings/bloc/user_settings_bloc.dart';
import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

@RoutePage()
class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final currencyItems = <String>['USD', 'EUR', 'JPY'];
  final appThemeModeItems = <String>['Dark', 'Light', 'System'];

  final _userSettingsBloc = UserSettingsBloc(
    GetIt.I<AbstractUserSettingsRepository>(),
  );

  @override
  void initState() {
    _userSettingsBloc.add(LoadUserSettings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: BlocBuilder<UserSettingsBloc, UserSettingsState>(
        bloc: _userSettingsBloc,
        builder: (context, state) {
          if (state is UserSettingsLoaded) {
            final repo = GetIt.I<AbstractUserSettingsRepository>();
            final userSettings = state.userSettings;
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Select currency',
                  style: theme.textTheme.bodyMedium,
                ),
                BaseCard(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: currencyItems.length,
                    separatorBuilder: (context, i) => const Divider(),
                    itemBuilder: (context, i) {
                      final currName = currencyItems[i];
                      return ListTile(
                        title: Text(
                          currName,
                          style: theme.textTheme.bodyMedium,
                        ),
                        onTap: () {
                          repo.putUserSettings(
                            UserSettings(
                              favCurrency: currName,
                              appThemeMode: userSettings.appThemeMode,
                            ),
                          );
                          _userSettingsBloc.add(LoadUserSettings());
                        },
                        trailing: (userSettings.favCurrency == currName)
                            ? const Icon(
                                Icons.check,
                                color: Colors.orange,
                              )
                            : const Icon(null),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Select theme mode',
                  style: theme.textTheme.bodyMedium,
                ),
                BaseCard(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: appThemeModeItems.length,
                    separatorBuilder: (context, i) => const Divider(),
                    itemBuilder: (context, i) {
                      final themeMode = appThemeModeItems[i];
                      return ListTile(
                        title: Text(
                          themeMode,
                          style: theme.textTheme.bodyMedium,
                        ),
                        onTap: () {
                          repo.putUserSettings(
                            UserSettings(
                              favCurrency: userSettings.favCurrency,
                              appThemeMode: themeMode,
                            ),
                          );
                          _userSettingsBloc.add(LoadUserSettings());
                        },
                        trailing: (userSettings.appThemeMode == themeMode)
                            ? const Icon(
                                Icons.check,
                                color: Colors.orange,
                              )
                            : const Icon(null),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 21, 21, 21),
      ),
      child: child,
    );
  }
}
