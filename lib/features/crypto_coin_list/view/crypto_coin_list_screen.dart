import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/generated/l10n.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
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
    GetIt.I<AbstractLikedCryptoCoinsRepository>(),
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
        title: Text(S.of(context).cryptocurrencies),
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
            final likedCryptoCoinsRepo =
                GetIt.I<AbstractLikedCryptoCoinsRepository>();
            if (state is CryptoCoinListLoaded) {
              return ListView.separated(
                itemCount: state.cryptoCoinList.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) {
                  return CryptoCoinListTile(
                    cryptoCoin: state.cryptoCoinList[i],
                    likedCryptoCoins:
                        likedCryptoCoinsRepo.getLikedCryptoCoins(),
                    likedCryptoCoinsRepo: likedCryptoCoinsRepo,
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
