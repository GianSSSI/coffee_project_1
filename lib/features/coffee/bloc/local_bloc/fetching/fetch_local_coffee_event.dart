part of 'fetch_local_coffee_bloc.dart';

sealed class FetchLocalCoffeeEvent extends Equatable {
  const FetchLocalCoffeeEvent();

  @override
  List<Object> get props => [];
}

final class FetchLocalCoffee extends FetchLocalCoffeeEvent {}

final class FetchLocalCoffeeViaXml extends FetchLocalCoffeeEvent {}
