import 'package:coffee/features/index/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/index/model/exceptions/sql_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LocalCoffeeRepository {
  Future<Either<SqlException, List<LocalCoffee>>> getAllHotCoffee();
  Future<Either<SqlException, int>> intsertCoffee({
    required LocalCoffee coffee,
  });
}
