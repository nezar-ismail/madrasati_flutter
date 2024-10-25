import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/presintation/core/service/cubit/network_image_cubit.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';
import 'presintation/phone/features/sign_in/role_desesion.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // setup locator for dependency injection in gitIt
  setupLocator();
  
  // open hive, register adapters, and initialize
  await Hive.initFlutter();
  Hive.registerAdapter(LocalStudentAdapter());
  await Hive.openBox<LocalStudent>('userBox');

    runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NetworkImageCubit>()),
        BlocProvider(create: (context) => UserProfileCubit()),
      ],
      child: const MadrasatiApp(),
    ),
  );
  
}

class MadrasatiApp extends StatelessWidget {
  const MadrasatiApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Madrasati App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RoleDesesion(),
    );
  }
}

