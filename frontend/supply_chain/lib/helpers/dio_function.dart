import 'package:dio/dio.dart';
import 'package:googlemap_testapp/configs/global_config.dart';

/// **axios** function
/// - Used to fetch data or send data to the server.
/// - Has 1 parameters **token** and it is in nullable string
/// - returns dio functionalities such as post, get & etc.
Dio axios(String? token) {
  Dio dio = Dio();
  dio.options.baseUrl = SERVER_URL;
  dio.options.headers["accept"] = "Application/Json";
  dio.options.headers["content-type"] = 'application/json';
  dio.options.responseType = ResponseType.json;
  if (token != null) {
    dio.options.headers["Authorization"] = "Barear $token";
  }
  return dio;
}
