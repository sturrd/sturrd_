import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sturrd_flutter/core/network_info/network_info.dart';
import 'package:sturrd_flutter/features/login/data/datasources/firebase_remote_datasource.dart';
import 'package:sturrd_flutter/features/login/data/repositories/login_repository_impl.dart';
import 'package:sturrd_flutter/features/login/domain/repositories/login_repository.dart';
import 'package:sturrd_flutter/features/login/domain/usecases/get_user_from_phone_auth_sign_in.dart';
import 'package:sturrd_flutter/features/login/domain/usecases/sign_out.dart';
import 'package:sturrd_flutter/features/login/presentation/bloc/bloc.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/datasources/dates_data_remote_datasource.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/repositories/dates_data_repository_impl.dart';
import 'package:sturrd_flutter/features/sturrd/dates/domain/repositories/dates_data_repository.dart';
import 'package:sturrd_flutter/features/sturrd/dates/domain/usecases/get_dates_from_database.dart';
import 'package:sturrd_flutter/features/sturrd/dates/domain/usecases/get_dates_stream_from_database.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/bloc/dates_bloc/dates_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//Features
  //LoginFeature
  await loginInit();
  //DatesInfo feature.
  await datesInfoInit();
  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
}

Future<void> loginInit() async {
  //Bloc
  sl.registerFactory(() => LoginBloc(
        getUserFromPhoneAuthSignIn: sl(),
        removeUserBySigningOut: sl(),
      ));
  //Usecases
  sl.registerLazySingleton(() => GetUserFromPhoneAuthSignIn(sl()));
  sl.registerLazySingleton(() => RemoveUserBySigningOut(sl()));
  // Repository
  sl.registerLazySingleton<LoginRepository>(() =>
      LoginRepositoryImpl(firebaseRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(auth: null),
  );
}

Future<void> datesInfoInit() async {
  //Bloc
  sl.registerFactory(() => DatesBloc(
        getDatesFromDatabase: sl(),
        getDatesStreamFromDatabase: sl(),
      ));
  //Usecases
  sl.registerLazySingleton(() => GetDatesFromDatabase(repository: sl()));
  sl.registerLazySingleton(() => GetDatesStreamFromDatabase(repository: sl()));
  // Repository
  sl.registerLazySingleton<DatesDataRepository>(() => DatesDataRepositoryImpl(
        datesDataRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<DatesDataRemoteDataSource>(
    () => DatesDataRemoteDataSourceImpl(),
  );
}
