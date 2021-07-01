import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mithran/data/profile.dart';
import 'package:mithran/data/visitor.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/user.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class NewVisitorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewVisitorState();
  }
}

class _NewVisitorState extends State<NewVisitorPage>{
  final _newVisitorKey = GlobalKey<FormState>(); 
  Visitor visitor = Visitor();
  List users = [];
  var users_json;

  get_data() async{
    Profile profile = await Profile.get_profile_instance();
    users_json = await API().filter_user("organization=${profile.organization}&type=consumer");
    users_json.forEach((element) {
      users.add(User.fromMap(element));
    });
    setState(() {
      users=users;
    });
  }

  get_user_name(user_id){
    String full_name = "";
    users.forEach((user) {
      if (user.id == user_id){
        full_name = user.fullName;
      }
    });
    return full_name;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Visitor"),
      ),
      drawer: NavigationDrawer(),
      body: Form(
        key: _newVisitorKey,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Wrap(
              children: [
                // buildTextFormField(visitor.fullName, "Full Name"),
                // buildTextFormField(visitor.contactNumber, "Contact Number"),
                TypeAheadFormField(
                  initialValue: get_user_name(visitor.visiting),
                    onSuggestionSelected: (value){
                      print(value);
                      visitor.visiting = value['id'];
                      this.setState(() {
                        visitor = visitor;
                      });
                    },
                    itemBuilder: (context, value){
                      return Text(value['full_name']);
                    },
                    suggestionsCallback: (pattern) async{
                      return users_json;
                    }
                ),
                ElevatedButton(
                    onPressed: (){
                      print(visitor.toJson());
                      API().post_visitor(visitor.toJson());
                    },
                    child: Text("ADD")
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}