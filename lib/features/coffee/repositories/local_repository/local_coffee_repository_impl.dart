import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/core/exceptions/sql_exception.dart';
import 'package:coffee/features/coffee/repositories/local_repository/local_coffee_remote_repository.dart';
import 'package:coffee/services/database/coffee_dao.dart';
import 'package:fpdart/src/either.dart';

class LocalCoffeeRepositoryImpl implements LocalCoffeeRepository {
  final CoffeeDao _coffeeDao;

  LocalCoffeeRepositoryImpl({required CoffeeDao coffeeDao})
    : _coffeeDao = coffeeDao;

  @override
  Future<Either<SqlException, List<LocalCoffee>>> getAllHotCoffee() async {
    try {
      final coffeeList = await _coffeeDao.getAllCoffee();
      return right(coffeeList);
    } on SqlException catch (e) {
      return left(SqlException(message: e.message));
    }
  }

  @override
  Future<Either<SqlException, int>> intsertCoffee({
    required LocalCoffee coffee,
  }) async {
    try {
      final coffeeId = await _coffeeDao.insertCoffee(coffee);
      return right(coffeeId);
    } on SqlException catch (e) {
      return left(SqlException(message: e.message));
    }
  }

  @override
  Future<Either<SqlException, List<LocalCoffee>>>
  getAllHotCoffeeViaXml() async {
    try {
      final coffeeList = await _coffeeDao.getAllCoffeeViaXml();
      return right(coffeeList);
    } on SqlException catch (e) {
      return left(SqlException(message: e.message));
    }
  }

  @override
  Future<Either<SqlException, int>> intsertCoffeeViaXml({
    required LocalCoffee coffee,
  }) async {
    try {
      final coffeeId = await _coffeeDao.insertCoffeeViaXml(coffee);
      return right(coffeeId);
    } on SqlException catch (e) {
      return left(SqlException(message: e.message));
    }
  }
}
