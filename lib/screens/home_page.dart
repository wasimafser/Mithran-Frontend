
import 'package:flutter/material.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Mithran"),
      ),
    );
  }

}