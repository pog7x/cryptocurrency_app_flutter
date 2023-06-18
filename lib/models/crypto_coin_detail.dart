// Package imports:
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:cryptocurrency_app/models/constants.dart';

part 'crypto_coin_detail.g.dart';

@HiveType(typeId: cryptoCoinDetailHiveTypeID)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
    required this.price,
    required this.imageUrl,
  });

  @HiveField(0)
  @JsonKey(name: 'LASTUPDATE')
  final String lastUpdate;

  @HiveField(1)
  @JsonKey(name: 'HIGH24HOUR')
  final String high24Hour;

  @HiveField(2)
  @JsonKey(name: 'LOW24HOUR')
  final String low24Hour;

  @HiveField(3)
  @JsonKey(name: 'PRICE')
  final String price;

  @HiveField(4)
  @JsonKey(name: 'IMAGEURL', fromJson: _joinBaseURL)
  final String imageUrl;

  static _joinBaseURL(value) => 'https://www.cryptocompare.com/$value';

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [
        lastUpdate,
        high24Hour,
        low24Hour,
        price,
        imageUrl,
      ];
}
