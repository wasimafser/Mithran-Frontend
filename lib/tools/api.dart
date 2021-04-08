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

  signup(email, first_name, last_name, password) async{
    return await network_util.post(
        "$base_url/user_management/user/",
        jsonEncode({
          'email': email,
          'first_name': first_name,
          'last_name': last_name,
          'password': password,
          'type': 'consumer'
        }),
      require_admin: true,
    );
  }

  get_profile(user_id) async{
    return await network_util.get(
        "$base_url/user_management/profile/?user_id=$user_id",
    );
  }
  
  put_profile(data) async{
    return await network_util.put(
      "$base_url/user_management/profile/",
      data
    );
  }

  get_service_types() async{
    return await network_util.get(
      "$base_url/service/type/"
    );
  }

  get_service_status() async{
    return await network_util.get(
        "$base_url/service/status/"
    );
  }

  post_service(data) async{
    return await network_util.post(
        "$base_url/service/api/",
        data
    );
  }

  get_services(profile_id, type) async{
    if (type == 'consumer'){
      return await network_util.get(
          "$base_url/service/filter/?requested_by=$profile_id"
      );
    }else if (type == 'worker'){
      return await network_util.get(
          "$base_url/service/filter/?assigned_to=$profile_id"
      );
    }
  }
}