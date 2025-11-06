part of 'fetch_local_coffee_bloc.dart';

enum FetchCoffeeStatus { initial, loading, success, failed }

class FetchLocalCoffeeState extends Equatable {
  final List<LocalCoffee> coffeeList;
  final String? errorMessage;
  final FetchCoffeeStatus status;

  const FetchLocalCoffeeState({
    this.coffeeList = const [],
    this.errorMessage,
    this.status = FetchCoffeeStatus.initial,
  });

  FetchLocalCoffeeState copyWith({
    List<LocalCoffee>? coffeeList,
    String? errorMessage,
    FetchCoffeeStatus? status,
  }) {
    return FetchLocalCoffeeState(
      coffeeList: coffeeList ?? this.coffeeList,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [coffeeList, errorMessage, status];
}
