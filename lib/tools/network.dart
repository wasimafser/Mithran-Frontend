import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mithran/tools/local_data.dart';

var TOKEN;
// var ADMIN_TOKEN = "0ef8292f0dd89ee11c23353f7c572106d4a05665";
var ADMIN_TOKEN = "fafc6dc744dc6581b5471cf845f64d8e2c4dadd3";

set_token_instance(token){
  TOKEN = token;
}

set_token(token) {
  LocalData local_data = LocalData();
  local_data.set_data('token', token);
  set_token_instance(token);
}

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $TOKEN"},
    ).then((http.Response response) {
      final String res = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        // print(res);
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, var body, {Map headers, encoding, require_admin=false}) {
    var headers = {
      "Content-Type": "application/json",
    };
    if (TOKEN != null){
      if (require_admin == true){
        headers['Authorization'] = "Token $ADMIN_TOKEN";
      }else{
        headers['Authorization'] = "Token $TOKEN";
      }
    }

    return http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
      encoding: encoding
    ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(res);
        throw new Exception(
            "Error while fetching data. Status code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url, var body, {Map headers, encoding, require_admin=false}) {
    var headers = {
      "Content-Type": "application/json",
    };
    if (TOKEN != null){
      if (require_admin == true){
        headers['Authorization'] = "Token $ADMIN_TOKEN";
      }else{
        headers['Authorization'] = "Token $TOKEN";
      }
    }

    return http.put(
        Uri.parse(url),
        body: body,
        headers: headers,
        encoding: encoding
    ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(res);
        throw new Exception(
            "Error while fetching data. Status code $statusCode");
      }
      return _decoder.convert(res);
    });
  }
  
}
