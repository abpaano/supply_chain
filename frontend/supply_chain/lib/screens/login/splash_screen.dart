
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 2), () {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade300),
          ),
          const Center(
            child: SizedBox(
              height: 100,
              child: Positioned(
                child: Image(
                    image: AssetImage('assets/images/splash_images/dost.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
