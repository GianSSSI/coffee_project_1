import 'package:bloc/bloc.dart';
import 'package:coffee/features/index/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/index/repositories/local_repository/local_coffee_remote_repository.dart';
import 'package:equatable/equatable.dart';

part 'fetch_local_coffee_event.dart';
part 'fetch_local_coffee_state.dart';

class FetchLocalCoffeeBloc
    extends Bloc<FetchLocalCoffeeEvent, FetchLocalCoffeeState> {
  final LocalCoffeeRepository _localCoffeeRepository;
  FetchLocalCoffeeBloc({required LocalCoffeeRepository localCoffeeRepository})
    : _localCoffeeRepository = localCoffeeRepository,
      super(FetchLocalCoffeeState()) {
    on<FetchLocalCoffee>((event, emit) async {
      emit(state.copyWith(status: FetchCoffeeStatus.loading));

      final response = await _localCoffeeRepository.getAllHotCoffee();

      response.fold(
        (exception) => emit(
          state.copyWith(
            status: FetchCoffeeStatus.failed,
            errorMessage: exception.message,
          ),
        ),
        (list) {
          print("COFFEE LIST: ${list}");
          emit(
            state.copyWith(status: FetchCoffeeStatus.success, coffeeList: list),
          );
        },
      );
    });
  }
}
