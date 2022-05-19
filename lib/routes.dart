import 'package:qtest/config/env.dart';

class ApiRoutes {
  static const String devBaseUrl = "https://jsonplaceholder.typicode.com/";
  static const String stagBaseUrl = "https://jsonplaceholder.typicode.com/";
  static const String prodBaseUrl = "https://jsonplaceholder.typicode.com/";

  //COMMENTS
  static String searchComments = FlavorConfig.instance.flavorValue.baseUrl + "comments";
}
