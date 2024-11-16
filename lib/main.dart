import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:madrasati/data/config/configration.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/presintation/phone/features/splash/view/splash_screen.dart';
import 'package:madrasati/presintation/update/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup locator for dependency injection in gitIt
  setupLocator();

  // open hive, register adapters, and initialize
  await Hive.initFlutter();
  Hive.registerAdapter(LocalUserAdapter());
  await Hive.openBox<LocalUser>('userBox');
  isUptoDate = await Configration.isUptoDate();
  await BaseUrl.initialize();


  runApp(
    const MadrasatiApp(),
  );
}

// global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late final dynamic isUptoDate;

class MadrasatiApp extends StatelessWidget {
  const MadrasatiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Madrasati App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: isUptoDate == true ? const SplashScreen() : Update(updateUrl: isUptoDate['url'],));
  }
}
