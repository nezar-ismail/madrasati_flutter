import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register AuthApi (or other dependencies of AuthService)
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<API>(() => API(getIt<Dio>()));

  getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<API>()));

  // Register SecureStorageApi
  getIt.registerLazySingleton<SecureStorageApi>(() => SecureStorageApi());

  // Register AuthService with its dependencies
  getIt.registerLazySingleton<AuthService>(() => AuthService(
        getIt<AuthApi>(),
        getIt<SecureStorageApi>(),
      ));

  // Register SignInCubit after AuthService
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<AuthService>()));
  // Register SchoolApi, SchoolService, and SchoolCubit
  getIt.registerLazySingleton<SchoolApi>(() => SchoolApi(getIt<API>()));
  getIt.registerLazySingleton<SchoolService>(() => SchoolService(getIt<SchoolApi>()));
  getIt.registerLazySingleton<SchoolCubit>(() => SchoolCubit(getIt<SchoolService>()));
}
