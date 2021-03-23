import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/local_data.dart';
import 'package:mithran/tools/network.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';
// import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  API api = API();
  final _loginKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: ScreenSize.isSmallScreen(context) ? EdgeInsets.zero : EdgeInsets.all(200),
          child: Flex(
            direction: ScreenSize.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                  child: Image.network("https://picsum.photos/1280/720"),
                // child: ColoredBox(color: Colors.red),
                flex: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: ScreenSize.isSmallScreen(context) ? EdgeInsets.only(left: 10, right: 10) : EdgeInsets.only(left: 50, right: 50),
                  alignment: Alignment.center,
                  child: Form(
                    key: _loginKey,
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Text("Login"),
                        SizedBox(
                          width: ScreenSize.isSmallScreen(context) ? ScreenSize.getScreenWidth(context)/2.5 : ScreenSize.getScreenWidth(context)/5,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                            ),
                            onChanged: (value){
                              setState(() {
                                this.email = value;
                              });
                            },
                            validator: (value) => value.isEmpty ? 'Username cannot be blank' : null,
                          ),
                        ),
                        // SizedBox(height: 10),
                        SizedBox(
                          width: ScreenSize.isSmallScreen(context) ? ScreenSize.getScreenWidth(context)/2.5 : ScreenSize.getScreenWidth(context)/5,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                            ),
                            obscureText: true,
                            onChanged: (value){
                              setState(() {
                                this.password = value;
                              });
                            },
                            validator: (value) => value.isEmpty ? 'Password cannot be blank' : null,
                          ),
                        ),
                        // SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () => {
                              if (_loginKey.currentState.validate()){
                                this.login()
                              }
                            },
                            child: Text("LOGIN"),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  login() async{
    Map response = await api.login(this.email, this.password);
    if (response.keys.contains('error')){
      print("ERROR");
    }else{
      set_token(response['token']);
      User.set_user_instance(response['user']);
      LocalData local_data = LocalData();
      response['user'].forEach((key, value) {
        local_data.set_data(key, value);
      });

      Navigator.popAndPushNamed(context, "/home");
    }
  }

}