import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/router/router.dart';

class CryptoCoinListTile extends StatelessWidget {
  const CryptoCoinListTile({super.key, required this.cryptoCoin});

  final CryptoCoin cryptoCoin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: () {
        AutoRouter.of(context).push(CryptoCoinRoute(cryptoCoin: cryptoCoin));
      },
      hoverColor: Colors.black.withOpacity(.1),
      leading: Image.network(cryptoCoin.detail.imageUrl),
      trailing: const Icon(
        Icons.arrow_forward,
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
  }
}
