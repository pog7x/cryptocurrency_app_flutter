part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoCoinInitial extends CryptoCoinState {}

class CryptoCoinLoading extends CryptoCoinState {}

class CryptoCoinLoaded extends CryptoCoinState {
  CryptoCoinLoaded({
    required this.cryptoCoin,
  });

  final CryptoCoin cryptoCoin;

  @override
  List<Object?> get props => [cryptoCoin];
}

class CryptoCoinLoadingError extends CryptoCoinState {
  CryptoCoinLoadingError({
    required this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
