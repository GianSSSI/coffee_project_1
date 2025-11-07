import 'package:coffee/features/coffee/model/coffee/remote_coffee/remote_coffee_model.dart';
import 'package:coffee/features/coffee/model/exceptions/api_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RemoteCoffeeRepository {
  Future<Either<ApiException, List<RemoteCoffee>>> getHotCoffees();
}
