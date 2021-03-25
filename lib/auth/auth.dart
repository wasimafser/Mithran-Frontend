import 'package:flutter/material.dart';
import 'package:mithran/auth/login.dart';
import 'package:mithran/auth/signup.dart';
import 'package:mithran/tools/screen_size.dart';

class AuthPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AuthState();
  }
}

class AuthState extends State<AuthPage> {

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
                flex: ScreenSize.isSmallScreen(context) ? 1 : 2,
              ),
              Expanded(
                flex: 1,
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                            tabs: [
                              Tab(text: "LOGIN",),
                              Tab(text: "SIGN-UP",)
                            ]
                        ),
                        Container(
                          height: ScreenSize.getScreenHeight(context) / 2.5,
                          child: TabBarView(
                              children: [
                                LoginPage(),
                                SignUpPage()
                              ]
                          ),
                        )
                      ],
                    )
                )
              )
            ],
          ),
        ),
      ),
    );
  }

}