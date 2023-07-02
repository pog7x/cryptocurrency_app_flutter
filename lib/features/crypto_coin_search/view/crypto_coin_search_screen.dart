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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusNode = FocusNode(canRequestFocus: true);
    return Scaffold(
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
                hideSuggestionsOnKeyboardHide: false,
                loadingBuilder: (BuildContext context) => Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                ),
                noItemsFoundBuilder: (BuildContext context) => Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Text(
                      'No items found',
                      style: theme.textTheme.bodyMedium,
                    ),
                    // child: const CircularProgressIndicator(),
                  ),
                ),
                itemSeparatorBuilder: (context, i) => const Divider(
                  height: .5,
                ),
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  focusNode: focusNode,
                  onTapOutside: (PointerDownEvent event) => focusNode.unfocus(),
                  style: theme.textTheme.labelMedium,
                  decoration: const InputDecoration(
                    hintText: 'e.g., BTC',
                  ),
                ),
                suggestionsCallback: (String pattern) async {
                  final searchRequest = _getCoinsNames(pattern);
                  if (searchRequest.isNotEmpty) {
                    return cryptoCoinRepo.getCryptoCoinList(
                      userSettingsRepo.getUserSettings().favCurrency,
                      searchRequest,
                    );
                  }
                  return <CryptoCoin>[];
                },
                itemBuilder: (BuildContext context, CryptoCoin coin) {
                  return CryptoCoinListTile(
                    cryptoCoin: coin,
                    userSettings: userSettingsRepo.getUserSettings(),
                    userSettingsRepo: userSettingsRepo,
                  );
                },
                onSuggestionSelected: (CryptoCoin coin) {
                  AutoRouter.of(context).push(
                    CryptoCoinRoute(
                      cryptoCoin: coin,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getCoinsNames(String pattern) {
    if (pattern.isNotEmpty) {
      return allCryptoCoins
          .where(
            (i) => i.toLowerCase().startsWith(
                  pattern.toLowerCase(),
                ),
          )
          .toList();
    } else {
      return allCryptoCoins.sublist(0, 15);
    }
  }
}
