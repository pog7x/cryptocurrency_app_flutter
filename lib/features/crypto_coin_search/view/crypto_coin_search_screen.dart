import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_it/get_it.dart';

import 'package:cryptocurrency_app/features/constants.dart';
import 'package:cryptocurrency_app/features/crypto_coin_list/crypto_coin_list.dart';
import 'package:cryptocurrency_app/generated/l10n.dart';
import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';
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
  final likedCryptoCoinsRepo = GetIt.I<AbstractLikedCryptoCoinsRepository>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusNode = FocusNode(canRequestFocus: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).search),
        leading: const AutoLeadingButton(),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(S.of(context).putYourSearchRequest),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TypeAheadField(
                focusNode: focusNode,
                hideKeyboardOnDrag: true,
                hideWithKeyboard: false,
                hideOnUnfocus: false,
                hideOnSelect: false,
                hideOnEmpty: false,
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
                emptyBuilder: (BuildContext context) => Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Text(
                      S.of(context).noItemsFound,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                itemSeparatorBuilder: (context, i) => const Divider(
                  height: .5,
                ),
                // textFieldConfiguration: TextFieldConfiguration(
                //   autofocus: true,
                //   focusNode: focusNode,
                //   onTapOutside: (PointerDownEvent event) => focusNode.unfocus(),
                //   style: theme.textTheme.labelMedium,
                //   decoration: InputDecoration(
                //     hintText: S.of(context).egBtc,
                //   ),
                // ),
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onTapOutside: (PointerDownEvent event) {
                      focusNode.unfocus();
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: S.of(context).egBtc,
                    ),
                  );
                },
                suggestionsCallback: (String pattern) async {
                  final searchRequest = _coinsSearchRequest(pattern);
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
                    likedCryptoCoinsRepo: likedCryptoCoinsRepo,
                    likedCryptoCoins:
                        likedCryptoCoinsRepo.getLikedCryptoCoins(),
                  );
                },
                onSelected: (CryptoCoin coin) {
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

  List<String> _coinsSearchRequest(String pattern) {
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
