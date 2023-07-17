import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/features/user_settings/user_settings.dart';
import 'package:cryptocurrency_app/generated/l10n.dart';
import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:cryptocurrency_app/ui/widgets/base_card.dart';

@RoutePage()
class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final currencyItems = <String>[
    currencyItemUSD,
    currencyItemEUR,
    currencyItemJPY,
  ];
  final appThemeModeItems = appThemeModeMap.keys.toList();
  final userLocaleItems = userLocaleMap.keys.toList();

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
        title: Text(S.of(context).settings),
        leading: const AutoLeadingButton(),
      ),
      body: BlocBuilder<UserSettingsBloc, UserSettingsState>(
        bloc: _userSettingsBloc,
        builder: (context, state) {
          if (state is UserSettingsLoaded) {
            final repo = GetIt.I<AbstractUserSettingsRepository>();
            final userSettings = state.userSettings;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).selectCurrency,
                    style: theme.textTheme.bodyMedium,
                  ),
                  BaseCard(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
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
                                userLocale: userSettings.userLocale,
                              ),
                            );
                            _userSettingsBloc.add(LoadUserSettings());
                          },
                          trailing: (userSettings.favCurrency == currName)
                              ? const Icon(Icons.check)
                              : const Icon(null),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).selectThemeMode,
                    style: theme.textTheme.bodyMedium,
                  ),
                  BaseCard(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appThemeModeItems.length,
                      separatorBuilder: (context, i) => const Divider(),
                      itemBuilder: (context, i) {
                        final themeMode = appThemeModeItems[i];
                        return ListTile(
                          title: Text(
                            ctxAppThemeMode(context, themeMode),
                            style: theme.textTheme.bodyMedium,
                          ),
                          onTap: () {
                            repo.putUserSettings(
                              UserSettings(
                                appThemeMode: themeMode,
                                favCurrency: userSettings.favCurrency,
                                userLocale: userSettings.userLocale,
                              ),
                            );
                            _userSettingsBloc.add(LoadUserSettings());
                          },
                          trailing: (userSettings.appThemeMode == themeMode)
                              ? const Icon(Icons.check)
                              : const Icon(null),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).selectLanguage,
                    style: theme.textTheme.bodyMedium,
                  ),
                  BaseCard(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userLocaleItems.length,
                      separatorBuilder: (context, i) => const Divider(),
                      itemBuilder: (context, i) {
                        final userLocale = userLocaleItems[i];
                        return ListTile(
                          title: Text(
                            userLocaleMap[userLocale]!,
                            style: theme.textTheme.bodyMedium,
                          ),
                          onTap: () {
                            repo.putUserSettings(
                              UserSettings(
                                appThemeMode: userSettings.appThemeMode,
                                favCurrency: userSettings.favCurrency,
                                userLocale: userLocale,
                              ),
                            );
                            _userSettingsBloc.add(LoadUserSettings());
                          },
                          trailing: (userSettings.userLocale == userLocale)
                              ? const Icon(Icons.check)
                              : const Icon(null),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
