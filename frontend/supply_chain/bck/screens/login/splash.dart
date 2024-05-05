import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade300),
          ),
          Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_5gpk3azc.json',
                  repeat: true,
                  reverse: true,
                  animate: true),

              // child: Positioned(
              //   child: Image(
              //     image: AssetImage('assets/images/splash_images/dost.png'),

              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
