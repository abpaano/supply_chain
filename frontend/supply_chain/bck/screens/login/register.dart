import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googlemap_testapp/components/my_button.dart';
import 'package:googlemap_testapp/components/my_textfield.dart';
// import 'package:googlemap_testapp/components/square_tile.dart';
import 'package:googlemap_testapp/screens/login/login.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  final validator;
  const RegisterScreen({super.key, required this.onTap, required this.validator});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? roleStatus = "";
  _RegisterScreenState() {
    roleStatus = _role[0];
  }
  //role dropdown
  final _role = ["Role", "Supplier", "Vendor"];

// sign up user
  Future<Map<String, dynamic>> registerAdmin(String name, String email,
      String password, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('http://localhost:8001/api/register/admin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register admin');
    }
  }

  void handleAdminRegistration() async {
    try {
      final response = await registerAdmin(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text);
      print(response['message']);
      print(response['access_token']);
    } catch (error) {
      print(error);
    }
  }

  // sign up user
  void signUserUp() async {
    final url = Uri.parse('http://localhost:8001/api/register/user');
    final response = await http.post(
      url,
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _confirmPasswordController.text
      },
    );

    if (response.statusCode == 201) {
      final token = response.body;
      print(token);
      print('Successfully registered!');
      // Save the token to persistent storage for future use.
      // You can use the shared_preferences package to achieve this.
    } else {
      // Show an error message to the user.
      // const message = "Invalid!";
      // // ignore: use_build_context_synchronously
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: const Text('Error'),
      //     content: const Text(message),
      //     actions: [
      //       TextButton(
      //         onPressed: () => Navigator.of(context).pop(),
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   ),
      // Map<String, dynamic> jsonMap = jsonDecode(response.body);
      print(response.body);
    }
  }

  // sign up user
  void signUserIn() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    onTap: () {},
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041014),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                //logo
                // Image.asset(
                //   'images/dost.png',
                //   height: 120,
                // ),
                const Icon(
                  Icons.lock,
                  size: 90,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),

                //Welcome back
                const Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

                const SizedBox(height: 50),

                // user textfield

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      value: roleStatus,
                      items: _role
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          roleStatus = val as String;
                        });
                      }),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  obscureText: false,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Enter valid email' : null,
                ),
                //pass field
                const SizedBox(height: 10),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Enter valid email' : null,
                ),
                //pass field
                const SizedBox(height: 10),

                MyTextField(
                  // validator: (value) =>
                  //     value.isEmpty ? 'Enter valid password' : null,
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  // validator: (value) =>
                  //     value.isEmpty ? 'Enter valid password' : null,
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 40),

                //sign in button
                MyButton(
                  onTap: handleAdminRegistration,
                  text: 'Sign Up',
                  txtstyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  color: Colors.white,
                ),
                const SizedBox(height: 120),

                //continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'or continue with ...',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 15),

                // // google / apple sign in
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     //google
                //     SquareTile(imagePath: 'images/google2.png'),
                //   ],
                // ),
                // const SizedBox(height: 10),

                //not a member?

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
