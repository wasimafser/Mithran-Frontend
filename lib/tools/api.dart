import 'dart:convert';

import 'package:mithran/tools/network.dart';

class API {
  final NetworkUtil network_util = NetworkUtil();

  String base_url = "http://127.0.0.1:8000";

  login(email, password) async{
    return await network_util.post(
        "$base_url/user_management/api-token-auth/",
        jsonEncode({
          'email': email,
          'password': password
        })
    );

  }
}