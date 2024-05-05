import 'dart:convert';
//import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:googlemap_testapp/components/auth.dart';
import 'package:googlemap_testapp/components/my_button.dart';
import 'package:googlemap_testapp/components/my_textfield.dart';
// import 'package:googlemap_testapp/components/square_tile.dart';
import 'package:googlemap_testapp/screens/add_data_screen.dart';
import 'package:googlemap_testapp/screens/edit_delete_product.dart';
// import 'package:googlemap_testapp/screens/login/register.dart';
// import 'package:googlemap_testapp/screens/login/login_or_register.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:googlemap_testapp/components/AuthService.dart';
// import '../flutter_map_screens.dart';
import 'package:googlemap_testapp/components/onboarding.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  String email = "";
  String password = "";
  String error = "";
  // sign up user
  void signUserUp() {
    setState(() {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => RegisterScreen(
      //               onTap: () {},
      //               validator: null,
      //             )));
    });
  }

  void _login() async {
    String roleGet = getRole();

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/login/role'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );
    if (response.statusCode == 200) {
      final token = response.body;
      var data = jsonDecode(token);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int asd = int.parse(response.body['access_token']);
      // prefs.setString(
      //   'access_token',
      // );
      // print('Token: $token');
      // String role = data[0]['id'];
      // if (role == 'vendor') {
      // print(role);
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddDataScreen()));
      });
      // }
    } else {
      final message = (jsonDecode(response.body));

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid'),
          content: Text((message).toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // print('Login Failed');
    }
  }

  // void _validator() {
  //   (value) {
  //     if (value == null || value.isEmpty) {
  //       return 'Please enter your email';
  //     }
  //     return null;
  //   };
  // }

  // register in user
  // void signUserIn() {
  //   Map creds = {
  //     'email': _emailController.text,
  //     'password': _passwordController.text,
  //     'device_name': 'iphone',
  //   };

  //   if (_formkey.currentState?.validate() == true) {
  //     Provider.of<Auth>(context, listen: false).login(creds: creds);
  //     print(_emailController.text);
  //     // setState(() {
  //     //   Navigator.push(context,
  //     //       MaterialPageRoute(builder: (context) => const FlutterMapScreens()));
  //     // });
  //     try {} catch (e) {}
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String? validateInput(String? input) {
      if (input == null || input.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF2596BE),
      body: Form(
        child: SafeArea(
          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  //logo
                  Image.asset(
                    'images/dost.png',
                    height: 150,
                  ),
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  //   color: Colors.black,
                  // ),
                  const SizedBox(height: 50),

                  //Welcome back
                  const Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 30),

                  // user textfield
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                    // validator: validateInput,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your email';
                    //   }
                    //   return null;
                    // },
                  ),

                  //pass field
                  const SizedBox(height: 10),
                  MyTextField(
                    // validator: validateInput,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your email';
                    //   }
                    //   return null;
                    // },
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  //forgot pass
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MyButton(
                      onTap: () {
                        final currentState = _formkey.currentState;
                        if (currentState != null && currentState.validate()) {
                          _login();
                        } else {
                          _login();
                        }
                      },
                      text: 'Sign In',
                      txtstyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      color: const Color.fromARGB(255, 187, 21, 71),
                    ),
                  ),
                  const SizedBox(height: 210),

                  //continue with
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Not a member?',
                  //         style: TextStyle(color: Colors.grey[800]),
                  //       ),
                  //       const SizedBox(width: 40.0),
                  //       GestureDetector(
                  //         onTap: widget.onTap,
                  //         child: const Text(
                  //           'Register now',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 50),

                  //not a member?

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Create an account!',
                  //       style: TextStyle(color: Colors.grey[700]),
                  //     ),
                  //     // const SizedBox(width: 40),
                  //     // GestureDetector(
                  //     //   onTap: widget.onTap,
                  //     //   child: const Text(
                  //     //     'Register now',
                  //     //     style: TextStyle(
                  //     //       color: Colors.blue,
                  //     //       fontWeight: FontWeight.bold,
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
