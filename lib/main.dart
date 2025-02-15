import 'package:clean_life_capston_project/providers/Loginprovider.dart';
import 'package:clean_life_capston_project/providers/signupprovider.dart';
import 'package:clean_life_capston_project/resources/theme_manager.dart';
import 'package:clean_life_capston_project/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>signupprovider()),
        ChangeNotifierProvider(create: (context)=>loginprovider()),
      ],
      child: MaterialApp(
        theme: getApplicationTheme(),
        home: SplashView(),
      ),
    );
  }
}




