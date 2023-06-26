import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cryptocurrency_app/models/constants.dart';
import 'package:cryptocurrency_app/models/crypto_coin_detail.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: cryptoCoinHiveTypeID)
class CryptoCoin {
  const CryptoCoin({
    required this.name,
    required this.detail,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final CryptoCoinDetail detail;
}
