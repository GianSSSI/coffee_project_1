part of 'insert_local_coffee_bloc.dart';

sealed class InsertLocalCoffeeEvent extends Equatable {
  const InsertLocalCoffeeEvent();

  @override
  List<Object> get props => [];
}

final class InsertCoffee extends InsertLocalCoffeeEvent {
  final RemoteCoffee remoteCoffee; // conveert in handler to localcof
  final String label;

  const InsertCoffee({required this.remoteCoffee, required this.label});
}

final class InsertCoffeeViaXml extends InsertLocalCoffeeEvent {
  final RemoteCoffee remoteCoffee; // conveert in handler, to localcof
  final String label;

  const InsertCoffeeViaXml({required this.remoteCoffee, required this.label});
}
