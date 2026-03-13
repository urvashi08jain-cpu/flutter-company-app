import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/company_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

import 'services/hive_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  await Firebase.initializeApp();

  /// Initialize Hive
  await Hive.initFlutter();

  /// Check user session
  bool isLoggedIn = await HiveService().isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {

  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CompanyProvider(),
        ),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        title: "Company App",

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        /// Session handling
        home: isLoggedIn
            ? HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}