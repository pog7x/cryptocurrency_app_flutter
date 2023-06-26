import 'package:cryptocurrency_app/models/user_settings.dart';
import 'package:cryptocurrency_app/repositories/user_settings.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/router/router.dart';

class CryptoCoinListTile extends StatefulWidget {
  const CryptoCoinListTile({
    super.key,
    required this.cryptoCoin,
    required this.userSettings,
    required this.userSettingsRepo,
  });

  final CryptoCoin cryptoCoin;
  final UserSettings userSettings;
  final AbstractUserSettingsRepository userSettingsRepo;

  @override
  State<CryptoCoinListTile> createState() => _CryptoCoinListTileState();
}

class _CryptoCoinListTileState extends State<CryptoCoinListTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLikedCrypto =
        widget.userSettings.likedCryptocoins.contains(widget.cryptoCoin.name);

    return ListTile(
      onTap: () {
        AutoRouter.of(context).push(
          CryptoCoinRoute(cryptoCoin: widget.cryptoCoin),
        );
      },
      hoverColor: Colors.black.withOpacity(.1),
      leading: Image.network(widget.cryptoCoin.detail.imageUrl),
      trailing: IconButton(
        icon: (isLikedCrypto)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
        onPressed: () {
          if (isLikedCrypto) {
            widget.userSettings.likedCryptocoins.remove(widget.cryptoCoin.name);
          } else {
            widget.userSettings.likedCryptocoins.add(widget.cryptoCoin.name);
          }
          widget.userSettingsRepo.putUserSettings(
            UserSettings(
              favCurrency: widget.userSettings.favCurrency,
              appThemeMode: widget.userSettings.appThemeMode,
              likedCryptocoins: widget.userSettings.likedCryptocoins,
            ),
          );
          setState(() {});
        },
      ),
      title: Text(
        widget.cryptoCoin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        widget.cryptoCoin.detail.price,
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}
