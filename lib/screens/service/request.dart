import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mithran/data/consumer.dart';
import 'package:mithran/data/service.dart';
import 'package:mithran/data/service_type.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class ServiceRequestPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ServiceRequestState();
  }

}

class _ServiceRequestState extends State<ServiceRequestPage>{
  final _serviceRequestKey = GlobalKey<FormState>();
  Service service = Service();
  List service_types = [];

  get_service_types() async{
    List service_types_temp = await API().get_service_types();
    service_types_temp.forEach((element) {
      service_types.add(
        ServiceType.fromMap(element)
      );
    });

    setState(() {
      service_types = service_types;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_service_types();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Request"),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: Form(
          key: _serviceRequestKey,
          child: Wrap(
            direction: ScreenSize.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            spacing: 10,
            children: [
              SizedBox(
                width: ScreenSize.getScreenWidth(context) / 2.5,
                child: DropdownButtonFormField(
                  hint: Text("Service Type"),
                    value: service.type,
                    items: service_types.map((element) =>
                      DropdownMenuItem(
                          child: Text(element.name),
                        value: element.id,
                      )
                    ).toList(),
                  onChanged: (value){
                      setState(() {
                        service.type = value;
                      });
                  },
                  validator: (value) => value == null ? "Select a service type" : null,
                ),
              ),
              SizedBox(
                height: ScreenSize.getScreenHeight(context) / 2.5,
                width: ScreenSize.getScreenWidth(context) / 2.5,
                child: TextFormField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  initialValue: service.comments,
                  decoration: InputDecoration(
                    labelText: "Comments",
                    filled: true
                  ),
                  onChanged: (value){
                    setState(() {
                      service.comments = value;
                    });
                  },
                  validator: (value) => value == null ? "Explain your problem" : null,
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    if (_serviceRequestKey.currentState.validate()){
                      request_service();
                    }
                  },
                  child: Text("Request")
              )
            ],
          ),
        ),
      ),
    );
  }

  request_service() async{
    Consumer consumer = await Consumer.get_consumer_instance();
    service.requestedBy = consumer.id;
    Map response = await API().post_service(service.toJson());
    if (response.containsKey("id")){
      Navigator.popAndPushNamed(context, "/service/history");
    }else{
      response.forEach((key, value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value), backgroundColor: Colors.red)
        );
      });
    }
  }

}