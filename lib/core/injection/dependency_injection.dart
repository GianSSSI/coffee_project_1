import 'package:coffee/features/index/bloc/coffee_bloc.dart';
import 'package:coffee/features/index/repositories/coffee_repository.dart';
import 'package:coffee/features/index/repositories/coffee_repository_impl.dart';
import 'package:coffee/helpers/validation/cubit/form_validation_cubit.dart';
import 'package:coffee/services/api/coffee_api_service.dart';
import 'package:coffee/services/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initDependencies() {
  //DIO
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient(dio: sl()));

  //Api servs
  sl.registerLazySingleton(() => CoffeeApiService(sl<Dio>()));

  //repo
  sl.registerLazySingleton<CoffeeRepository>(
    () => CoffeeRepositoryImpl(coffeeApiService: sl<CoffeeApiService>()),
  );

  //bloc
  sl.registerLazySingleton(
    () => CoffeeBloc(coffeeRepository: sl<CoffeeRepository>()),
  );

  //validation cubit
  sl.registerFactory(() => FormValidationCubit());
}
