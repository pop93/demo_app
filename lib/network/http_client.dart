import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:qtest/utils/logger.dart';

class HttpClient {

  static Future<http.Response?> get(String url) async {
    final logger = LoggerHelper.logger;

    try {
      logger.d("START HTTP.GET url=" + url);
      var response = await http.get(
        Uri.parse(url),
      );
      logger.d("END HTTP.GET url=" +
          url +
          " responseCode=" +
          response.statusCode.toString());
      return response;
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException
        logger.d("Socket exception ${e.toString()}");
        print("Socket exception: ${e.toString()}");
        return null;
      } else if (e is TimeoutException) {
        logger.d("TimeOut exception ${e.toString()}");
        return null;
      } else {
        logger.d("Unhandled exception ${e.toString()}");
      }
      return null;
    }
  }
}
