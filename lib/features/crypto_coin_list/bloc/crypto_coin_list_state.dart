part of 'crypto_coin_list_bloc.dart';

abstract class CryptoCoinListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoCoinListInitial extends CryptoCoinListState {}

class CryptoCoinListLoading extends CryptoCoinListState {}

class CryptoCoinListLoaded extends CryptoCoinListState {
  CryptoCoinListLoaded({
    required this.cryptoCoinList,
  });

  final List<CryptoCoin> cryptoCoinList;

  @override
  List<Object?> get props => [cryptoCoinList];
}

class CryptoCoinListLoadingError extends CryptoCoinListState {
  CryptoCoinListLoadingError({
    required this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
