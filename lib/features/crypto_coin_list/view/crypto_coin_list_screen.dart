import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:cryptocurrency_app/router/router.dart';
import 'package:cryptocurrency_app/ui/widgets/error_page.dart';

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
            final userSettingsRepo = GetIt.I<AbstractUserSettingsRepository>();
            final userSettings = userSettingsRepo.getUserSettings();
            if (state is CryptoCoinListLoaded) {
              return ListView.separated(
                itemCount: state.cryptoCoinList.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) {
                  return CryptoCoinListTile(
                    cryptoCoin: state.cryptoCoinList[i],
                    userSettingsRepo: userSettingsRepo,
                    userSettings: userSettings,
                  );
                },
              );
            } else if (state is CryptoCoinListLoadingError) {
              return ErrorPage(
                onPressed: () {
                  _cryptoCoinListBloc.add(LoadCryptoCoinList());
                },
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
