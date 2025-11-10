import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/core/exceptions/sql_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LocalCoffeeRepository {
  Future<Either<SqlException, List<LocalCoffee>>> getAllHotCoffee();
  Future<Either<SqlException, int>> intsertCoffee({
    required LocalCoffee coffee,
  });

  //xml
  Future<Either<SqlException, List<LocalCoffee>>> getAllHotCoffeeViaXml();
  Future<Either<SqlException, int>> intsertCoffeeViaXml({
    required LocalCoffee coffee,
  });
}
