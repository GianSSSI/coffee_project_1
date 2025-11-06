import 'package:bloc/bloc.dart';
import 'package:coffee/features/index/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/index/model/coffee/remote_coffee_model.dart';
import 'package:coffee/features/index/repositories/local_repository/local_coffee_remote_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'insert_local_coffee_event.dart';
part 'insert_local_coffee_state.dart';

class InsertLocalCoffeeBloc
    extends Bloc<InsertLocalCoffeeEvent, InsertLocalCoffeeState> {
  final LocalCoffeeRepository _localCoffeeRepository;
  InsertLocalCoffeeBloc({required LocalCoffeeRepository localCoffeeRepository})
    : _localCoffeeRepository = localCoffeeRepository,
      super(InsertLocalCoffeeState()) {
    on<InsertCoffee>((event, emit) async {
      emit(state.copyWith(status: InsertCoffeeStatus.loading));

      final localCoffee = LocalCoffee.fromRemoteCoffee(
        event.remoteCoffee,
        label: event.label,
      );
      final response = await _localCoffeeRepository.intsertCoffee(
        coffee: localCoffee,
      );

      response.fold(
        (e) {
          emit(
            state.copyWith(
              errorMessage: e.message,
              status: InsertCoffeeStatus.failed,
            ),
          );
        },
        (id) {
          emit(
            state.copyWith(status: InsertCoffeeStatus.success, coffeeId: id),
          );
        },
      );
    });
  }
}
