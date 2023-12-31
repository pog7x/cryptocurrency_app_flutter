import 'package:cryptocurrency_app/models/crypto_coin.dart';

abstract class AbstractCryptoCoinRepository {
  Future<List<CryptoCoin>> getCryptoCoinList(
    String currency,
    List<String> cryptoCurrList,
  );
  Future<CryptoCoin> cryptoCoinDetail(String curr, cryptoCurr);
}
