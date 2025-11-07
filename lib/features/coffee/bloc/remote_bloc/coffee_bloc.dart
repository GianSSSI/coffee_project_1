import 'package:bloc/bloc.dart';
import 'package:coffee/features/coffee/model/coffee/remote_coffee/remote_coffee_model.dart';
import 'package:coffee/features/coffee/repositories/remote_repository/remote_coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final RemoteCoffeeRepository _coffeeRepository;

  CoffeeBloc({required RemoteCoffeeRepository coffeeRepository})
    : _coffeeRepository = coffeeRepository,
      super(const CoffeeState()) {
    on<FetchHotCoffee>((event, emit) async {
      emit(state.copyWith(status: CoffeeStatus.loading));

      final response = await _coffeeRepository.getHotCoffees();

      response.fold(
        (exception) => emit(
          state.copyWith(
            status: CoffeeStatus.failure,
            errorMessage: exception.message,
          ),
        ),
        (list) {
          debugPrint("COFFEE LIST: $list");
          emit(state.copyWith(status: CoffeeStatus.success, coffeeList: list));
        },
      );
    });
  }
}
