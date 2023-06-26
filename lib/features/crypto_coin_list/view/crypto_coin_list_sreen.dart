import 'dart:async';

import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:cryptocurrency_app/router/router.dart';

@RoutePage()
class CryptoCoinListScreen extends StatefulWidget {
  const CryptoCoinListScreen({super.key});

  @override
  State<CryptoCoinListScreen> createState() => _CryptoCoinListScreenState();
}

class _CryptoCoinListScreenState extends State<CryptoCoinListScreen> {
  final _cryptoCoinListBloc = CryptoCoinListBloc(
    GetIt.I<AbstractCryptoCoinRepository>(),
    GetIt.I<AbstractUserSettingsRepository>(),
  );

  @override
  void initState() {
    _cryptoCoinListBloc.add(LoadCryptoCoinList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cryptocurrency App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              AutoRouter.of(context).push(const UserSettingsRoute());
            },
          ),
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: GetIt.I<Talker>(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoCoinListBloc.add(
            LoadCryptoCoinList(
              completer: completer,
            ),
          );
          return completer.future;
        },
        child: BlocBuilder<CryptoCoinListBloc, CryptoCoinListState>(
          bloc: _cryptoCoinListBloc,
          builder: (context, state) {
            if (state is CryptoCoinListLoaded) {
              return ListView.separated(
                itemCount: state.cryptoCoinList.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) {
                  final cryptoCoinRepo =
                      GetIt.I<AbstractUserSettingsRepository>();
                  final cryptoCoin = state.cryptoCoinList[i];
                  final userSettings = cryptoCoinRepo.getUserSettings();
                  final isLikedCrypto =
                      userSettings.likedCryptocoins.contains(cryptoCoin.name);
                  return ListTile(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(CryptoCoinRoute(cryptoCoin: cryptoCoin));
                    },
                    hoverColor: Colors.black.withOpacity(.1),
                    leading: Image.network(cryptoCoin.detail.imageUrl),
                    trailing: IconButton(
                      icon: (isLikedCrypto)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      onPressed: () {
                        final userSettings = cryptoCoinRepo.getUserSettings();
                        final isLikedCrypto = userSettings.likedCryptocoins
                            .contains(cryptoCoin.name);
                        if (isLikedCrypto) {
                          userSettings.likedCryptocoins.remove(cryptoCoin.name);
                        } else {
                          userSettings.likedCryptocoins.add(cryptoCoin.name);
                        }
                        cryptoCoinRepo.putUserSettings(
                          UserSettings(
                            favCurrency: userSettings.favCurrency,
                            appThemeMode: userSettings.appThemeMode,
                            likedCryptocoins: userSettings.likedCryptocoins,
                          ),
                        );
                        _cryptoCoinListBloc.add(LoadCryptoCoinList());
                      },
                    ),
                    title: Text(
                      cryptoCoin.name,
                      style: theme.textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      cryptoCoin.detail.price,
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                },
              );
            } else if (state is CryptoCoinListLoadingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _cryptoCoinListBloc.add(LoadCryptoCoinList());
                      },
                      child: const Text('Try again'),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
