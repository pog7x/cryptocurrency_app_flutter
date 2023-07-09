import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';
import 'package:cryptocurrency_app/router/router.dart';

class CryptoCoinListTile extends StatefulWidget {
  const CryptoCoinListTile({
    super.key,
    required this.cryptoCoin,
    required this.likedCryptoCoins,
    required this.likedCryptoCoinsRepo,
  });

  final CryptoCoin cryptoCoin;
  final List<String> likedCryptoCoins;
  final AbstractLikedCryptoCoinsRepository likedCryptoCoinsRepo;

  @override
  State<CryptoCoinListTile> createState() => _CryptoCoinListTileState();
}

class _CryptoCoinListTileState extends State<CryptoCoinListTile> {
  late List<String> _likedCryptoCoins;

  @override
  void initState() {
    _likedCryptoCoins = widget.likedCryptoCoins;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coinName = widget.cryptoCoin.name;
    final isLikedCrypto = _likedCryptoCoins.contains(coinName);
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
            _likedCryptoCoins.remove(coinName);
          } else {
            _likedCryptoCoins.add(coinName);
          }
          widget.likedCryptoCoinsRepo.putLikedCryptoCoins(_likedCryptoCoins);
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
