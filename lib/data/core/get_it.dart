import 'package:get_it/get_it.dart';
import 'package:madrasati/presintation/phone/features/sign_in/cubit/sign_in_cubit.dart';


// Create an instance of GetIt
final GetIt getIt = GetIt.instance;

// This function will be used to register dependencies
void setupLocator() {
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt()));

}
