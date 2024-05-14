import 'package:flutter/foundation.dart';
import 'user.dart';

class UserRoleProvider with ChangeNotifier {
  String? _currentRole;

  String? get currentRole => _currentRole;

  void setRole(String role) {
    _currentRole = role;
    notifyListeners();
  }
  
  void logout() {
    _currentRole = null;
    notifyListeners();
  }
}
