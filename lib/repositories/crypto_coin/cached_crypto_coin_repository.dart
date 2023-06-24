import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';

class CachedCryptoCoinRepository implements AbstractCryptoCoinRepository {
  CachedCryptoCoinRepository({
    required this.repo,
    required this.cryptoCoinsBox,
  });

  final CryptoCoinRepository repo;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCryptoCoinList(String currency) async {
    var cryptoCoinList = <CryptoCoin>[];

    try {
      cryptoCoinList = await repo.getCryptoCoinList(currency);
      cryptoCoinList.sort(((a, b) => a.name.compareTo(b.name)));
      await cryptoCoinsBox.putAll({for (var e in cryptoCoinList) e.name: e});
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
      cryptoCoinList = cryptoCoinsBox.values.toList();
    }

    return cryptoCoinList;
  }

  @override
  Future<CryptoCoin> cryptoCoinDetail(String curr, cryptoCurr) async {
    CryptoCoin cryptoCoin;

    try {
      cryptoCoin = await repo.cryptoCoinDetail(curr, cryptoCurr);
      await cryptoCoinsBox.put(cryptoCurr, cryptoCoin);
    } catch (err, stack) {
      GetIt.I<Talker>().handle(err, stack);
      cryptoCoin = cryptoCoinsBox.get(cryptoCurr)!;
    }

    return cryptoCoin;
  }
}
