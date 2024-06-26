import 'package:flutter/material.dart';
import 'package:googlemap_testapp/screens/consumer_login.dart';
import 'package:googlemap_testapp/screens/flutter_map_screens.dart';
import 'package:googlemap_testapp/screens/login/login_or_register.dart';
import 'package:googlemap_testapp/screens/seller_login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:googlemap_testapp/components/userRoleProvider.dart';

final client = http.Client();

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F1EC),
      body: Stack(
        children: [
          DiagonalBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/isupplychain.png', // Replace 'your_image.png' with the path to your image asset
                  width: 180, // Adjust image width as needed
                  height: 180, // Adjust image height as needed
                ),
                SizedBox(height: 20),
                Text(
                  'iSupplyChain',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 50),
                Text(
                  'Choose your type of account.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                /*ElevatedButton(
                  onPressed: () async {
                    await callTestSessionRoute();
                    await callRetrieveSessionRoute();
                  },
                  child: Text('Test Sessions'),
                ),*/
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<UserRoleProvider>(context, listen: false).setRole('consumer');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConsumerLoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                        0xFF28666E), // Background color for Consumer button
                    fixedSize: Size(250, 50), // Adjust button width and height
                  ),
                  child: Text(
                    'Consumer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<UserRoleProvider>(context, listen: false).setRole('seller');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerLoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF90CED5), // Background color for Seller button
                    fixedSize: Size(250, 50), // Adjust button width and height
                  ),
                  child: Text('Seller', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlutterMapScreens()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .white, // Background color for Continue as Guest button
                    foregroundColor:
                        Colors.black, // Text color for Continue as Guest button
                    fixedSize: Size(250, 50), // Adjust button width and height
                  ),
                  child: Text('Continue as Guest'),
                ),
                SizedBox(height: 50),
                Text(
                  'brought to you by',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
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
        ],
      ),
    );
  }
}

class DiagonalBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: _DiagonalPainter(),
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white; // Background color
    final path = Path();
    path.moveTo(0, 0); // Start at top-left corner
    path.lineTo(size.width, size.height * 1); // Diagonal line to bottom-right
    path.lineTo(size.width, 0); // Top-right corner
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Future<void> callTestSessionRoute() async {
  final baseUrl = 'http://10.0.2.2:8000';
  final url = Uri.parse('$baseUrl/test-session');
  try {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      print('Session data set successfully!');
    } else {
      print('Error setting session data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error calling test-session route: $error');
  }
}

Future<void> callRetrieveSessionRoute() async {
  final baseUrl = 'http://10.0.2.2:8000';
  final url = Uri.parse('$baseUrl/retrieve-session');
  try {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error retrieving session data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error calling retrieve-session route: $error');
  }
}
