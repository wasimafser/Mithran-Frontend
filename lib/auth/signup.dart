import 'package:flutter/material.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/local_data.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';

class SignUpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }

}

class _SignUpPageState extends State<SignUpPage>{
  API api = API();
  final _signUpKey = GlobalKey<FormState>();
  String email, first_name, last_name, password, confirm_password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ScreenSize.isSmallScreen(context) ? EdgeInsets.only(left: 10, right: 10) : EdgeInsets.only(left: 50, right: 50),
      alignment: Alignment.center,
      child: Form(
        key: _signUpKey,
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
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
            SizedBox(
              width: ScreenSize.isSmallScreen(context) ? ScreenSize.getScreenWidth(context)/2.5 : ScreenSize.getScreenWidth(context)/5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  filled: true,
                ),
                onChanged: (value){
                  setState(() {
                    this.first_name = value;
                  });
                },
                validator: (value) => value.isEmpty ? 'First Name is required' : null,
              ),
            ),
            SizedBox(
              width: ScreenSize.isSmallScreen(context) ? ScreenSize.getScreenWidth(context)/2.5 : ScreenSize.getScreenWidth(context)/5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  filled: true,
                ),
                onChanged: (value){
                  setState(() {
                    this.last_name = value;
                  });
                },
              ),
            ),
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
            ElevatedButton(
              onPressed: () => {
                if (_signUpKey.currentState.validate()){
                  this.signup()
                }
              },
              child: Text("SUBMIT"),
            )
          ],
        ),
      ),
    );
  }

  signup() async{
    Map response = await api.signup(this.email, this.first_name, this.last_name, this.password);
    if (response.keys.contains('error')){
      print("ERROR");
    }else{
      User.set_user_instance(response);
      LocalData local_data = LocalData();
      response.forEach((key, value) {
        local_data.set_data(key, value);
      });

      Navigator.popAndPushNamed(context, "/home");
    }
  }

}