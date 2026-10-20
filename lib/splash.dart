import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:onlinetranslator/main.dart';

void main() {
  runApp(const Splash());
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const splash_logo_style = TextStyle(
    fontFamily: "Irs",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const loading_style = TextStyle(
    fontFamily: "Irs",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: EasySplashScreen(
          logo: Image.asset("assets/Logo.png"),
          title: Text("مترجم آنلاین متون", style: splash_logo_style),
          backgroundColor: Colors.white,
          showLoader: true,
          loaderColor: Colors.blue,
          loadingText: Text("... در حال دریافت اطلاعات", style: loading_style),
          durationInSeconds: 5,
          navigator: Main(),
        ),
      ),
    );
  }
}
