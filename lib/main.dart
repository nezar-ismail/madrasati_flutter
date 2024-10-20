import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'presintation/features/sign_in/role_desesion.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  // open hive, register adapters, and initialize
  await Hive.initFlutter();
  Hive.registerAdapter(LocalStudentAdapter());
  await UserBox.init(); 


  runApp(const MadrasatiApp());
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

