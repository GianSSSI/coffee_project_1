import 'package:coffee/features/index/model/coffee/remote_coffee_model.dart';
import 'package:coffee/features/index/model/exceptions/api_exception.dart';
import 'package:coffee/features/index/repositories/remote_repository/remote_coffee_repository.dart';
import 'package:coffee/services/api/coffee_api_service.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RemoteCoffeeRepositoryImpl implements RemoteCoffeeRepository {
  final CoffeeApiService _coffeeApiService;

  RemoteCoffeeRepositoryImpl({required CoffeeApiService coffeeApiService})
    : _coffeeApiService = coffeeApiService;
  @override
  Future<Either<ApiException, List<RemoteCoffee>>> getHotCoffees() async {
    print("CALLED getHotCoffees");
    try {
      final coffeeList = await _coffeeApiService.getHotCoffees();
      print("COFFEELIST: ${coffeeList}");
      return right(coffeeList);
    } on DioException catch (e) {
      final error = e.error;
      if (error is ApiException) {
        return left(error);
      } else {
        return left(ApiException("Unexpected error: ${e.message}"));
      }
    }
  }
}
