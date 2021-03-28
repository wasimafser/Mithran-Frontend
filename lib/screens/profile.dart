
import 'package:flutter/material.dart';
import 'package:mithran/data/consumer.dart';
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
  Consumer consumer;

  _get_consumer() async{
    consumer = await Consumer.get_consumer_instance();
    setState(() {
      consumer = consumer;
    });
  }

  @override
  void initState() {
    super.initState();
    _get_consumer();
  }

  @override
  Widget build(BuildContext context) {
    if(consumer != null){
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
                buildTextFormField(consumer.contactNumber, "Contact Number", required: true),
                buildTextFormField(consumer.alternateContactNumber, "Alternate Contact Number"),
                buildTextFormField(consumer.doorNumber, "Door Number / Floor", required: true),
                buildTextFormField(consumer.address, "Address", required: true),
                buildTextFormField(consumer.organization, "Organization Code", required: true),
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
              consumer.contactNumber = value;
            }else if(labelText == "Alternate Contact Number"){
              consumer.alternateContactNumber = value;
            }else if(labelText == "Door Number / Floor"){
              consumer.doorNumber = value;
            }else if(labelText == "Address"){
              consumer.address = value;
            }else if(labelText == "Organization Code"){
              consumer.organization = value;
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
    Map response = await API().put_consumer(consumer.toJson());
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