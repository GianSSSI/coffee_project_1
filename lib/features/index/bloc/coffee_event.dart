part of 'coffee_bloc.dart';

@immutable
sealed class CoffeeEvent {}

final class FetchHotCoffee extends CoffeeEvent {}
