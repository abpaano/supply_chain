import 'package:flutter/material.dart';

class SellerLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F1EB),
      appBar: AppBar(
        title: Text('Seller Account'),
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
                    'Manage your own \nonline business',
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
                onPressed: () {
                  // TODO: Handle Login logic
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
                endIndent: 60.0
              ),
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
