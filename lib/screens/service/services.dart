import 'package:flutter/material.dart';
import 'package:mithran/data/profile.dart';
import 'package:mithran/data/service.dart';
import 'package:mithran/data/service_status.dart';
import 'package:mithran/data/service_type.dart';
import 'package:mithran/screens/service/details.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class AssignedServices extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AssignedServicesState();
  }
}

class _AssignedServicesState extends State<AssignedServices>{
  List services = [];
  List service_types = [];
  List service_status = [];

  get_services() async{
    User user = User.get_user_instance();
    Profile profile = await Profile.get_profile_instance();
    List services_temp = await API().get_services(profile.id, user.type);
    List types_temp = await API().get_service_types();
    List status_temp = await API().get_service_status();
    services_temp.forEach((element) {
      services.add(Service.fromMap(element));
    });
    types_temp.forEach((element) {
      service_types.add(ServiceType.fromMap(element));
    });
    status_temp.forEach((element) {
      service_status.add(ServiceStatus.fromMap(element));
    });
    setState(() {
      services = services;
      service_types = service_types;
      service_status = service_status;
    });
  }

  @override
  void initState() {
    super.initState();
    get_services();
  }

  get_service_type(type_id){
    for (var value in service_types) {
      if (value.id == type_id){
        return value.name;
      }
    }
  }

  get_service_status(status_id){
    for (var value in service_status) {
      if (value.id == status_id){
        return value.name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigned Services"),
      ),
      drawer: NavigationDrawer(),
      body: Card(
        margin: ScreenSize.isSmallScreen(context) ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 200, vertical: 20),
        child: ListView.separated(
            separatorBuilder: (context, index){
              return SizedBox(
                height: 10,
              );
            },
            itemCount: services.length,
            itemBuilder: (context, index){
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Text(services[index].id.toString()),
                title: Text("Requested By : ${services[index].requestedBy.user.fullName}"),
                subtitle: Text("Type : ${get_service_type(services[index].type)}"),
                trailing: Text("Status : ${get_service_status(services[index].status)}"),
                tileColor: Colors.grey,
                onTap: (){
                  Navigator.popAndPushNamed(context, "/service/details", arguments: services[index]);
                },
              );
            }
        ),
      ),
    );
  }

}