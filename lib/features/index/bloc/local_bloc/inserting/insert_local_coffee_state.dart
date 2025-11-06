part of 'insert_local_coffee_bloc.dart';

enum InsertCoffeeStatus { initial, loading, success, failed }

class InsertLocalCoffeeState extends Equatable {
  final int? coffeeId;
  final String? errorMessage;
  final InsertCoffeeStatus status;

  const InsertLocalCoffeeState({
    this.coffeeId,
    this.errorMessage,
    this.status = InsertCoffeeStatus.initial,
  });

  InsertLocalCoffeeState copyWith({
    int? coffeeId,
    String? errorMessage,
    InsertCoffeeStatus? status,
  }) {
    return InsertLocalCoffeeState(
      coffeeId: coffeeId ?? this.coffeeId,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [coffeeId, errorMessage, status];
}
