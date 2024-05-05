import 'package:flutter/material.dart';
import 'package:googlemap_testapp/screens/login/login_or_register.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

bool adminRole = true;

class GetRole {}

String getRole() {
  if (adminRole) {
    return '/admin';
  } else {
    return '/user';
  }
}

class _OnBoardingState extends State<OnBoarding> {
  void _vendorOntap() {
    setState(() {
      adminRole = false;
      Navigator.push(
        context, // Use the context associated with the LoginOrRegisterPage widget
        MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
      );
    });
  }

  void _supplierOntap() {
    setState(() {
      Navigator.push(
        context, // Use the context associated with the LoginOrRegisterPage widget
        MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        LiquidSwipe(
          pages: [
            OnBoardingPage(size: size),
            Container(
              color: const Color(0xFF063970),
              padding: const EdgeInsets.fromLTRB(50, 180, 50, 0),
              child: Column(
                children: [
                  SizedBox(
                      height: 210,
                      width: 210,
                      child: Image(
                          image: const AssetImage('assets/images/supplier.png'),
                          height: size.height * 0.5,
                          fit: BoxFit.cover)),
                  const SizedBox(
                    height: 60.0,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Login as a Supplier?',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('To Get Started, please sign in!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(
                    height: 180.0,
                  ),
                  GestureDetector(
                    onTap: _supplierOntap,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign in!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: const Color(0xFFFFE500),
              padding: const EdgeInsets.fromLTRB(50, 120, 50, 0),
              child: Column(
                children: [
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Image(
                          image: const AssetImage('assets/images/vendor.png'),
                          height: size.height * 0.5,
                          fit: BoxFit.cover)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Login as a Vendor?',
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('To Get Started, please sign in!',
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 180.0,
                  ),
                  GestureDetector(
                    onTap: _vendorOntap,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign in!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 150, 50, 0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: size.height * 0.2,
              child: Image(
                image: const AssetImage('images/dost.png'),
                height: size.height,
              )),
          const Column(
            children: [
              Text(
                'Welcome to DOST Supply Chain App',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('To Get Started, Please Swipe Left or Right!',
              textAlign: TextAlign.center),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}
