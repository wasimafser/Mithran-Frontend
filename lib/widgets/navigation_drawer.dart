
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
    this.setState(() {
      user = user;
    });
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
    if (user != null){
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(user.fullName == null ? "" : user.fullName),
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
            if (user.type == 'consumer')
              ListTile(
                title: Text("New Service Request"),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/service/request");
                },
              ),
            if (user.type == 'consumer')
              ListTile(
                title: Text("Request History"),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/service/history");
                },
              ),
            if (user.type == 'worker')
              ListTile(
                title: Text("Services"),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/services");
                },
              ),
            if (user.type == 'security')
              ListTile(
                title: Text("Add New Visitor"),
                onTap: (){
                  Navigator.popAndPushNamed(context, "/visitor/new");
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
    }else{
      return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Text("LOADING")
            )
          ],
        ),
      );
    }
  }
}