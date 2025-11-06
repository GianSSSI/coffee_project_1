import 'package:coffee/features/index/model/coffee/coffee_model.dart';
import 'package:coffee/features/index/model/exceptions/api_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CoffeeRepository {
  Future<Either<ApiException, List<Coffee>>> getHotCoffees();
}
