import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crypto_tracking_app/ui/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        animationDuration: const Duration(seconds: 3),
        splashIconSize: 500,
        splash: const Center(
          child: Image(
            image: AssetImage('assets/images/money-exchange.png'),
          ),
        ),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 1000,
      ),
    );
  }
}
