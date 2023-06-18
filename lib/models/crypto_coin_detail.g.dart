// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinDetailAdapter extends TypeAdapter<CryptoCoinDetail> {
  @override
  final int typeId = 2;

  @override
  CryptoCoinDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinDetail(
      lastUpdate: fields[0] as String,
      high24Hour: fields[1] as String,
      low24Hour: fields[2] as String,
      price: fields[3] as String,
      imageUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lastUpdate)
      ..writeByte(1)
      ..write(obj.high24Hour)
      ..writeByte(2)
      ..write(obj.low24Hour)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetail _$CryptoCoinDetailFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetail(
      lastUpdate: json['LASTUPDATE'] as String,
      high24Hour: json['HIGH24HOUR'] as String,
      low24Hour: json['LOW24HOUR'] as String,
      price: json['PRICE'] as String,
      imageUrl: CryptoCoinDetail._joinBaseURL(json['IMAGEURL']),
    );

Map<String, dynamic> _$CryptoCoinDetailToJson(CryptoCoinDetail instance) =>
    <String, dynamic>{
      'LASTUPDATE': instance.lastUpdate,
      'HIGH24HOUR': instance.high24Hour,
      'LOW24HOUR': instance.low24Hour,
      'PRICE': instance.price,
      'IMAGEURL': instance.imageUrl,
    };
