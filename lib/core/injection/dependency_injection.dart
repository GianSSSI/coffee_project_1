import 'package:coffee/features/coffee/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:coffee/features/coffee/bloc/local_bloc/inserting/insert_local_coffee_bloc.dart';
import 'package:coffee/features/coffee/bloc/remote_bloc/coffee_bloc.dart';
import 'package:coffee/features/coffee/repositories/local_repository/local_coffee_remote_repository.dart';
import 'package:coffee/features/coffee/repositories/local_repository/local_coffee_repository_impl.dart';
import 'package:coffee/features/coffee/repositories/remote_repository/remote_coffee_repository.dart';
import 'package:coffee/features/coffee/repositories/remote_repository/remote_coffee_repository_impl.dart';
import 'package:coffee/helpers/validation/cubit/form_validation_cubit.dart';
import 'package:coffee/services/api/coffee_api_service.dart';
import 'package:coffee/services/database/app_database.dart';
import 'package:coffee/services/database/coffee_dao.dart';
import 'package:coffee/services/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initDependencies() {
  //validation cubit
  sl.registerFactory(() => FormValidationCubit());
  _initRemoteDependencies();
  _initLocalDependencies();
}

void _initLocalDependencies() {
  //database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  //DAO
  sl.registerLazySingleton<CoffeeDao>(
    () => CoffeeDao(appDatabase: sl<AppDatabase>()),
  );
  //repo
  sl.registerLazySingleton<LocalCoffeeRepository>(
    () => LocalCoffeeRepositoryImpl(coffeeDao: sl<CoffeeDao>()),
  );
  //bloc

  sl.registerFactory(
    () => InsertLocalCoffeeBloc(
      localCoffeeRepository: sl<LocalCoffeeRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => FetchLocalCoffeeBloc(
      localCoffeeRepository: sl<LocalCoffeeRepository>(),
    ),
  );
}

void _initRemoteDependencies() {
  //DIO
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient(dio: sl()));

  //Api servs
  sl.registerLazySingleton(() => CoffeeApiService(sl<Dio>()));

  //repo
  sl.registerLazySingleton<RemoteCoffeeRepository>(
    () => RemoteCoffeeRepositoryImpl(coffeeApiService: sl<CoffeeApiService>()),
  );

  //bloc
  sl.registerLazySingleton(
    () => CoffeeBloc(coffeeRepository: sl<RemoteCoffeeRepository>()),
  );
}
