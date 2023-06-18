part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinEvent extends Equatable {}

class LoadCryptoCoin extends CryptoCoinEvent {
  LoadCryptoCoin({
    this.completer,
    required this.cryptoCoin,
  });

  final Completer? completer;
  final CryptoCoin cryptoCoin;

  @override
  List<Object?> get props => [completer, cryptoCoin];
}
