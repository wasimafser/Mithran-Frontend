import 'package:flutter/material.dart';
import 'package:mithran/data/profile.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }

}

class _ProfilePageState extends State<ProfilePage>{
  final _profileKey = GlobalKey<FormState>();
  Profile profile;

  _get_profile() async{
    profile = await Profile.get_profile_instance();
    setState(() {
      profile = profile;
    });
  }

  @override
  void initState() {
    super.initState();
    _get_profile();
  }

  @override
  Widget build(BuildContext context) {
    if(profile != null){
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        drawer: NavigationDrawer(),
        body: Center(
          child: Form(
            key: _profileKey,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.center,
              children: [
                buildTextFormField(profile.contactNumber, "Contact Number", required: true),
                buildTextFormField(profile.alternateContactNumber, "Alternate Contact Number"),
                buildTextFormField(profile.doorNumber, "Door Number / Floor", required: true),
                buildTextFormField(profile.address, "Address", required: true),
                buildTextFormField(profile.organization, "Organization Code", required: true),
                ElevatedButton(
                    onPressed: (){
                      if (_profileKey.currentState.validate()){
                        update_consumer();
                      }
                    },
                    child: Text("SUBMIT")
                )
              ],
            ),
          ),
        ),
      );
    }else{
      return Container(
        child: Text("LOADING"),
      );
    }
  }

  buildTextFormField(initialValue, labelText, {bool required = false}) {
    return Container(
      width: ScreenSize.getScreenWidth(context) / 2.5,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: (value){
          setState(() {
            if (labelText == "Contact Number"){
              profile.contactNumber = value;
            }else if(labelText == "Alternate Contact Number"){
              profile.alternateContactNumber = value;
            }else if(labelText == "Door Number / Floor"){
              profile.doorNumber = value;
            }else if(labelText == "Address"){
              profile.address = value;
            }else if(labelText == "Organization Code"){
              profile.organization = value;
            }
          });
        },
        decoration: InputDecoration(
          labelText: labelText,
          filled: true
        ),
        validator: (value){
          if(required){
            return value.isEmpty ? "$labelText cannot be empty" : null;
          }
          return null;
        },
      ),
    );
  }

  update_consumer() async{
    Map response = await API().put_profile(profile.toJson());
    print(response);
    if (response.containsKey("id")){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Submitted Successfully"),
            backgroundColor: Colors.lightGreen,
          )
      );
    }else{
      response.keys.forEach((element) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response[element][0]),
              backgroundColor: Colors.red,
            )
        );
      });
    }
  }

}