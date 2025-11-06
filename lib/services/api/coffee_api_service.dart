import 'package:coffee/features/index/model/coffee/coffee_model.dart';
import 'package:coffee/helpers/configuration/app_config.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'coffee_api_service.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class CoffeeApiService {
  factory CoffeeApiService(Dio dio, {String baseUrl}) = _CoffeeApiService;

  @GET('/hot')
  Future<List<Coffee>> getHotCoffees();
}
