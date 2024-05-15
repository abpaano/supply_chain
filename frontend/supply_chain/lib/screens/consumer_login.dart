import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConsumerLoginScreen extends StatefulWidget {
  @override
  _ConsumerLoginScreenState createState() => _ConsumerLoginScreenState();
}

class _ConsumerLoginScreenState extends State<ConsumerLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F1EB),
      appBar: AppBar(
        title: Text('Consumer Account'),
        backgroundColor: Color(0xFFF5F1EB),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF28666E)),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content in the Row
                children: [
                  Image.asset(
                    'assets/images/isupplychain.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 10), // Add spacing
                  Text(
                    'Buy and explore in \nthe online market',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Text(
                'Enter account credentials',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.0),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.6, // Adjust the width as needed
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email/Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12), // Adjust padding
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.6, // Adjust the width as needed
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12), // Adjust padding
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
              ),

              TextButton(
                onPressed: () {
                  // TODO: Handle "Forgot password?" functionality
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                      color: Colors.grey[600],
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final loginResult = await loginConsumer(
                      emailController.text, passwordController.text);
                  if (loginResult != null) {
                    // Login successful!

                    // 1. Store token securely using flutter_secure_storage
                    final storage = FlutterSecureStorage();
                    await storage.write(
                        key: 'consumer_auth_token',
                        value: loginResult['access_token']);

                    // 2. Navigate to the Consumer Dashboard
                    Navigator.pushReplacementNamed(context, '/explore');
                  } else {
                    // Login failed. Handle error display.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Invalid email or password.'), // Or fetch error from API
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF28666E),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              SizedBox(height: 10.0),
              Divider(
                  // Add Divider
                  thickness: 1.5, // Adjust the thickness as needed
                  color: Color(0xFF28666E), // Set the color
                  indent: 60.0,
                  endIndent: 60.0),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle Signup logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF90CED5),
                  padding: EdgeInsets.symmetric(horizontal: 95, vertical: 15),
                ),
                child: Text('Signup',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              // Bottom Section
              Spacer(), // Push to bottom
              Text('brought to you by',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/dost.png', width: 50, height: 50),
                  SizedBox(width: 10),
                  Text(
                    // No Expanded widget needed anymore
                    'Department of\nScience and\nTechnology',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF28666E),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>?> loginConsumer(
    String email, String password) async {
  final baseUrl = 'http://10.0.2.2:8000/api';
  final loginUrl = Uri.parse('$baseUrl/consumer/login');

  try {
    final response = await http.post(
      loginUrl,
      body: jsonEncode({"email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];
      final userId = responseData['consumer']['id']; // Extract user ID
      print("User ID: $userId");

      // Store access token and user ID securely
      final storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'user_id', value: userId.toString());

      return responseData as Map<String, dynamic>;
    } else {
      throw Exception('Failed to login, status: ${response.statusCode}');
    }
  } catch (error) {
    print('Login error: $error');
    return null;
  }
}
