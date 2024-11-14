import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/presintation/phone/features/splash/view/splash_screen.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup locator for dependency injection in gitIt
  setupLocator();

  // open hive, register adapters, and initialize
  await Hive.initFlutter();
  Hive.registerAdapter(LocalUserAdapter());
  await Hive.openBox<LocalUser>('userBox');
  await UserBox.instance;

  

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserProfileCubit>()),
      ],
      child: const MadrasatiApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MadrasatiApp extends StatelessWidget {
  const MadrasatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Madrasati App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
