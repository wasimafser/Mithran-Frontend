
import 'package:flutter/material.dart';
import 'package:mithran/tools/local_data.dart';
import 'package:mithran/user.dart';

class NavigationDrawer extends StatefulWidget{
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  User user;
  
  get_user_info(){
    user = User.get_user_instance();
    print(user.fullName);
    // this.setState(() {
    //
    // });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user_info();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Text(user.fullName),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),
          ListTile(
            title: Text("Home"),
            onTap: (){
              Navigator.popAndPushNamed(context, "/home");
            },
          ),
          ListTile(
            title: Text("New Service Request"),
            onTap: (){
              Navigator.popAndPushNamed(context, "/service/request");
            },
          ),
          ListTile(
            title: Text("Profile"),
            onTap: (){
              Navigator.popAndPushNamed(context, "/profile");
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: (){
              LocalData.clear_data();
              Navigator.popAndPushNamed(context, "/auth");
            },
          )
        ],
      ),
    );
  }
}