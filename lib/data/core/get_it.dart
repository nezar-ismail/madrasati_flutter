import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_inspector.dart';
import 'package:madrasati/data/repo_apis/group_post_api.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_home_cubit_cubit.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

final GetIt getIt = GetIt.instance;

/// Register all the services and cubits in the locator
///
/// This function should be called once during the app initialization
///
void setupLocator() {
  // Register BaseApi (Dio, BaseAPI, SecureStorageApi
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<APIInspector>(() => APIInspector(getIt<Dio>()));
    getIt.registerLazySingleton<API>(() => API(getIt<APIInspector>()));
    getIt.registerLazySingleton<SecureStorageApi>(() => SecureStorageApi());

  // Register ApisRepository
    getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<API>()));
    getIt.registerLazySingleton<SchoolApi>(() => SchoolApi(getIt<API>()));
    getIt.registerLazySingleton<GroupPostApi>(() => GroupPostApi(getIt<API>()));

  // Register Services
    getIt.registerLazySingleton<AuthService>(() => AuthService(
        getIt<AuthApi>(),
        getIt<SecureStorageApi>(),
            ));
    getIt.registerLazySingleton<SchoolService>(
        () => SchoolService(getIt<SchoolApi>()));
    getIt.registerLazySingleton<GroupPostService>(
        () => GroupPostService(getIt<GroupPostApi>()));

  // Register LazySingleton Cubits
    getIt.registerLazySingleton<UserProfileCubit>(() => UserProfileCubit());
    getIt.registerLazySingleton<SchoolHomeCubit>(() => SchoolHomeCubit());




}
