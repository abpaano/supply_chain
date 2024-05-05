import 'package:googlemap_testapp/helpers/dio_function.dart';

/// **AuthService** Class
/// - This class have Authentication functionality
/// - Methods: **login**, **logout**, **register**, **fetchUserInfo**
class AuthService {
  /// **login** function
  /// - This function is use for logging in the client
  /// - Has 1 parameters **cred** and it is in map object {}
  /// - Map object requires **{ username: "", password: "" }**
  /// - returns token in future string
  Future<String> login(Map cred) async {
    final response = await axios(null).post("sanctum/token", data: cred);
    return response.data.toString();
  }

  /// **logout** function
  /// - This function is use for logging out the client
  /// - Has 1 parameters **token** and it is in string
  /// - returns future string
  Future<String> logout(String token) async {
    final response = await axios(token).get("logout");
    return response.data.toString();
  }

  /// **register** function
  /// - This function is use to create client account
  /// - Has 1 parameters **cred** and it is in map object {}
  /// - Map object requires **{ under development }**
  /// - returns token in future string
  Future<String> register(Map cred) async {
    final response = await axios(null).post("register", data: cred);
    return response.data.toString();
  }

  /// **register** function
  /// - This function is use to fetch client information
  /// - Has 1 parameters **token** and it is in string
  /// - returns user information in future string
  Future<String> fetchUserInfo(String token) async {
    final response = await axios(token).get("fetch-user");
    return response.data.toString();
  }
}
