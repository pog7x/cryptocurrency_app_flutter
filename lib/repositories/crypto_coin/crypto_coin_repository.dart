import 'dart:async';

import 'package:dio/dio.dart';

import 'package:cryptocurrency_app/models/crypto_coin.dart';
import 'package:cryptocurrency_app/models/crypto_coin_detail.dart';
import 'package:cryptocurrency_app/repositories/crypto_coin.dart';

const clientBaseURL = 'https://min-api.cryptocompare.com';

class CryptoCoinRepository implements AbstractCryptoCoinRepository {
  CryptoCoinRepository({
    required this.dio,
  }) {
    dio.options = BaseOptions(
      baseUrl: clientBaseURL,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 5),
    );
  }

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCryptoCoinList(
    String currency,
    List<String> cryptoCurrList,
  ) async {
    Response response = await dio.get(
      '/data/pricemultifull',
      queryParameters: {
        'fsyms': cryptoCurrList.join(','),
        'tsyms': currency,
      },
    );
    final data = response.data as Map<String, dynamic>;
    final dataDisplay = data['DISPLAY'] as Map<String, dynamic>;
    return dataDisplay.entries
        .map(
          (e) => CryptoCoin(
            name: e.key,
            detail: CryptoCoinDetail.fromJson(
              e.value[currency],
            ),
          ),
        )
        .toList();
  }

  @override
  Future<CryptoCoin> cryptoCoinDetail(String curr, cryptoCurr) async {
    Response response = await dio.get(
      '/data/pricemultifull',
      queryParameters: {
        'fsyms': cryptoCurr,
        'tsyms': curr,
      },
    );
    final data = response.data as Map<String, dynamic>;
    final dataDisplay = data['DISPLAY'] as Map<String, dynamic>;
    final cryptoData = dataDisplay[cryptoCurr] as Map<String, dynamic>;
    return CryptoCoin(
      name: cryptoCurr,
      detail: CryptoCoinDetail.fromJson(
        cryptoData[curr],
      ),
    );
  }

  Future<List<String>> getAllCoins() async {
    Response response = await dio.get(
      '/data/all/coinlist',
    );
    final data = response.data as Map<String, dynamic>;
    final dataData = data['Data'] as Map<String, dynamic>;
    return dataData.keys.toList();
  }
}
