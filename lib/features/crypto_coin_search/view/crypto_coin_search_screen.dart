import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:cryptocurrency_app/router/router.dart';

@RoutePage()
class CryptoCoinSearchScreen extends StatefulWidget {
  const CryptoCoinSearchScreen({super.key});

  @override
  State<CryptoCoinSearchScreen> createState() => _CryptoCoinSearchScreenState();
}

class _CryptoCoinSearchScreenState extends State<CryptoCoinSearchScreen> {
  final userSettingsRepo = GetIt.I<AbstractUserSettingsRepository>();
  final cryptoCoinRepo = GetIt.I<AbstractCryptoCoinRepository>();

  List<String> _getAllCoins(String pattern) {
    return allCryptoCoins
        .where(
          (i) => i.toLowerCase().startsWith(
                pattern.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusNode = FocusNode(canRequestFocus: true);
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      onVerticalDragStart: (e) => focusNode.unfocus(),
      onHorizontalDragStart: (e) => focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Search'),
          leading: const AutoLeadingButton(),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Put your search request:'),
              Container(
                padding: const EdgeInsets.all(16),
                child: TypeAheadField(
                  hideKeyboardOnDrag: true,
                  keepSuggestionsOnSuggestionSelected: true,
                  hideSuggestionsOnKeyboardHide: false,
                  loadingBuilder: (context) => Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 31, 31, 31),
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  noItemsFoundBuilder: (context) => Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 31, 31, 31),
                      ),
                      child: Text(
                        'No items found',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  itemSeparatorBuilder: (context, i) => const Divider(
                    height: .5,
                  ),
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    focusNode: focusNode,
                    style: theme.textTheme.labelMedium,
                    decoration: const InputDecoration(
                      hintText: 'e.g., BTC',
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    final searchRequest = _getAllCoins(pattern);
                    if (pattern != '' && searchRequest.isNotEmpty) {
                      return cryptoCoinRepo.getCryptoCoinList(
                        userSettingsRepo.getUserSettings().favCurrency,
                        searchRequest,
                      );
                    }
                    return <CryptoCoin>[];
                  },
                  itemBuilder: (context, CryptoCoin item) {
                    return CryptoCoinListTile(
                      cryptoCoin: item,
                      userSettings: userSettingsRepo.getUserSettings(),
                      userSettingsRepo: userSettingsRepo,
                    );
                  },
                  onSuggestionSelected: (item) {
                    AutoRouter.of(context)
                        .push(
                          CryptoCoinRoute(
                            cryptoCoin: item,
                          ),
                        )
                        .then((value) => focusNode.requestFocus());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
