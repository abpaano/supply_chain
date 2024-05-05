import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final String baseUrl = "http://10.0.2.2:8000";

  Future<String?> login(String email, String password) async {
    var response = await http.post(Uri.parse("$baseUrl/api/consumers"), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var token = response.body;
      await storage.write(key: "token", value: token);
      return null;
    } else {
      return "Invalid email or password";
    }
  }

  Future<void> logout() async {
    await storage.delete(key: "token");
  }
}
