import 'dart:async';
import 'package:crypto_tracking_app/services/repositories.dart';
import 'package:crypto_tracking_app/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Timer.periodic(const Duration(minutes: 14), (timer) async {
    callApiFunc();
  });

  runApp(const MyApp());
}

callApiFunc() async {
  await Repositories().latestCoinRepo("1", "200", "BDT");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
