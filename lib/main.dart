import 'package:flutter/material.dart';

import 'presintation/features/sign_in/role_desesion.dart';

void main() {
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

