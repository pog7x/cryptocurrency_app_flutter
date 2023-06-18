part of 'crypto_coin_list_bloc.dart';

abstract class CryptoCoinListEvent extends Equatable {}

class LoadCryptoCoinList extends CryptoCoinListEvent {
  LoadCryptoCoinList({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
