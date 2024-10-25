import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register BaseApi (Dio, BaseAPI, SecureStorageApi
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<API>(() => API(getIt<Dio>()));
  getIt.registerLazySingleton<SecureStorageApi>(() => SecureStorageApi());

  // Register ApisRepository
    getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<API>()));
    getIt.registerLazySingleton<SchoolApi>(() => SchoolApi(getIt<API>()));

  // Register Services
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthApi>(),getIt<SecureStorageApi>(),));
  getIt.registerLazySingleton<SchoolService>(() => SchoolService(getIt<SchoolApi>()));

  // Register Cubits
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<AuthService>()));
  getIt.registerLazySingleton<SchoolPagingCubit>(() => SchoolPagingCubit(getIt<SchoolService>()));
  getIt.registerLazySingleton<SchoolInfoCubit>(() => SchoolInfoCubit(getIt<SchoolService>()));
}
