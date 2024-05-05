import 'package:flutter/material.dart';
import 'package:googlemap_testapp/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  AuthService authService = AuthService();

  void login(Map cred) async {
    try {
      String item = await authService.login(cred);
      isLoggedIn = true;
      notifyListeners();
    } catch (e) {}
  }
}
