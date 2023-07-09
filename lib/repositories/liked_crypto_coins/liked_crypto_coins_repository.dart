import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/repositories/liked_crypto_coins.dart';

const likedCryptoCoinsBoxKey = 'liked_crypto_coins_box_key';

class LikedCryptoCoinsRepository implements AbstractLikedCryptoCoinsRepository {
  LikedCryptoCoinsRepository({
    required this.likedCryptoCoinsBox,
  });

  final Box<List<String>> likedCryptoCoinsBox;

  @override
  List<String> getLikedCryptoCoins() {
    var liked = <String>[];

    try {
      if (likedCryptoCoinsBox.containsKey(likedCryptoCoinsBoxKey)) {
        liked = likedCryptoCoinsBox.get(likedCryptoCoinsBoxKey)!;
      } else {
        likedCryptoCoinsBox.put(likedCryptoCoinsBoxKey, liked);
      }
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
    }

    return liked;
  }

  @override
  List<String> putLikedCryptoCoins(List<String> newLiked) {
    try {
      likedCryptoCoinsBox.put(likedCryptoCoinsBoxKey, newLiked);
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
    }

    return newLiked;
  }
}
