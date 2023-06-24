import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/crypto_coin/crypto_coin.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key, required this.cryptoCoin});

  final CryptoCoin cryptoCoin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoCoinBloc = CryptoCoinBloc(
    GetIt.I<AbstractCryptoCoinRepository>(),
    GetIt.I<AbstractUserSettingsRepository>(),
  );

  @override
  void initState() {
    _cryptoCoinBloc.add(LoadCryptoCoin(cryptoCoin: widget.cryptoCoin));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoCoinBloc.add(
            LoadCryptoCoin(
              completer: completer,
              cryptoCoin: widget.cryptoCoin,
            ),
          );
          return completer.future;
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
              bloc: _cryptoCoinBloc,
              builder: (context, state) {
                if (state is CryptoCoinLoaded) {
                  final coin = state.cryptoCoin;
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: Image.network(coin.detail.imageUrl),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          coin.name,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        BaseCard(
                          child: Center(
                            child: Text(
                              coin.detail.price,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        BaseCard(
                          child: Column(
                            children: [
                              _DataRow(
                                title: 'Hight 24 Hour',
                                value: coin.detail.high24Hour,
                              ),
                              const SizedBox(height: 6),
                              _DataRow(
                                title: 'Low 24 Hour',
                                value: coin.detail.low24Hour,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CryptoCoinLoadingError) {
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
                            _cryptoCoinBloc.add(
                              LoadCryptoCoin(
                                cryptoCoin: widget.cryptoCoin,
                              ),
                            );
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
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
