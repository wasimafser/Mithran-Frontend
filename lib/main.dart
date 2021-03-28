import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mithran/auth/auth.dart';
import 'package:mithran/auth/login.dart';
import 'package:mithran/screens/home_page.dart';
import 'package:mithran/screens/profile.dart';
import 'package:mithran/screens/service/history.dart';
import 'package:mithran/screens/service/request.dart';
import 'package:mithran/tools/local_data.dart';
import 'package:mithran/tools/network.dart';
import 'package:mithran/user.dart';

bool is_logged_in = false;

main() async{
  LocalData local_data = LocalData();
  var token = await local_data.get_data('token', String);
  if (token != ""){
    var user_model = {};
    List fields = ['id', 'full_name', 'first_name', 'last_name', 'email'];
    await fields.forEach((element) async{
      if (element == 'id'){
        user_model[element] = await local_data.get_data(element, int);
      }else{
        user_model[element] = await local_data.get_data(element, String);
      }
    });
    var user_model_json = jsonEncode(user_model);

    User.set_user_instance(user_model_json);
    set_token_instance(token);
    is_logged_in = true;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: is_logged_in ? "/home" : "/auth",
      routes: {
        "/auth": (context) => AuthPage(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/profile": (context) => ProfilePage(),
        "/service/request": (context) => ServiceRequestPage(),
        "/service/history": (context) => ServiceHistoryPage(),
      },
    );
  }
}
