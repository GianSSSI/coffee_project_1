part of 'coffee_bloc.dart';

enum CoffeeStatus { initial, loading, success, failure }

class CoffeeState extends Equatable {
  final List<Coffee> coffeeList;
  final String? errorMessage;
  final CoffeeStatus status;

  const CoffeeState({
    this.coffeeList = const [],
    this.errorMessage,
    this.status = CoffeeStatus.initial,
  });

  CoffeeState copyWith({
    List<Coffee>? coffeeList,
    String? errorMessage,
    CoffeeStatus? status,
  }) {
    return CoffeeState(
      coffeeList: coffeeList ?? this.coffeeList,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [coffeeList, status, errorMessage];
}
