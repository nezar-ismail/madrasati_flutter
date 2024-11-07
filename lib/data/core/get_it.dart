import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/repo_apis/group_post_api.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/data/services/school_service.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/group_posts/cubit/post_services_cubit.dart';
import 'package:madrasati/presintation/phone/features/home/cubit/home_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_group/cubit/groupe_post_pagination_cubit.dart';
import 'package:madrasati/presintation/phone/features/school_info/cubit/school_info_cubit.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register BaseApi (Dio, BaseAPI, SecureStorageApi
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<API>(() => API(getIt<Dio>()));
  getIt.registerLazySingleton<SecureStorageApi>(() => SecureStorageApi());

  // Register ApisRepository
    getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<API>()));
    getIt.registerLazySingleton<SchoolApi>(() => SchoolApi(getIt<API>()));
    getIt.registerLazySingleton<GroupPostApi>(() => GroupPostApi(getIt<API>()));

  // Register Services
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthApi>(),getIt<SecureStorageApi>(),));
  getIt.registerLazySingleton<SchoolService>(() => SchoolService(getIt<SchoolApi>()));
  getIt.registerLazySingleton<GroupPostService>(() => GroupPostService(getIt<GroupPostApi>()));

  // Register Cubits
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<AuthService>()));
  getIt.registerLazySingleton<SchoolPagingCubit>(() => SchoolPagingCubit(getIt<SchoolService>()));
  getIt.registerLazySingleton<SchoolInfoCubit>(() => SchoolInfoCubit(getIt<SchoolService>()));
  getIt.registerLazySingleton<UserProfileCubit>(() => UserProfileCubit());
  getIt.registerFactory<NetworkImageCubit>(() => NetworkImageCubit(getIt<API>()));
  getIt.registerFactory<PostServicesCubit>(() => PostServicesCubit(getIt<GroupPostService>()));
  getIt.registerFactory<GroupePostPaginationCubit>(() => GroupePostPaginationCubit(getIt<GroupPostService>())); // Register GroupePostPaginationCubit as a factory (non-singleton)
}
