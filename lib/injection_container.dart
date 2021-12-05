import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/network_info.dart';
import 'package:cinema_db/features/cinema/data/data_source/local_data_source.dart';
import 'package:cinema_db/features/cinema/data/repository/cinema_repository_impl.dart';
import 'package:cinema_db/features/cinema/domain/repository/cinema_repository.dart';
import 'package:cinema_db/features/cinema/domain/use_case/register_movie_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/cinema/presentation/manager/cinema_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory<CinemaBloc>(
    () => CinemaBloc(
      registerMovieUseCase: sl(),
    ),
  );
  // use cases
  sl.registerLazySingleton<RegisterMovieUseCase>(() => RegisterMovieUseCase(
        repository: sl(),
      ));

  // repository
  sl.registerLazySingleton<CinemaRepository>(
    () => CinemaRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // External Dependencies
  await Hive.initFlutter();
  await Hive.openBox<Map<String, dynamic>>(CommonConstants.cinemaBoxName);
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
