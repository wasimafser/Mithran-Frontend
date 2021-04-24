import 'package:flutter/material.dart';
import 'package:mithran/data/profile.dart';
import 'package:mithran/data/service.dart';
import 'package:mithran/data/service_state.dart';
import 'package:mithran/data/service_status.dart';
import 'package:mithran/data/service_type.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/user.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class ServiceHistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ServiceHistoryState();
  }
}

class _ServiceHistoryState extends State<ServiceHistoryPage>{
  List services = [];
  List service_types = [];
  List service_status = [];
  Map serviceStates = {};
  User user = User.get_user_instance();

  get_services() async{
    Profile profile = await Profile.get_profile_instance();
    List services_temp = await API().get_services(profile.id, user.type);
    List types_temp = await API().get_service_types();
    List status_temp = await API().get_service_status();
    services_temp.forEach((element) async{
      serviceStates[element['id']] = await ServiceState.get_servicestate_instance(element['id']);
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
      serviceStates = serviceStates;
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
    if (services != null){
      return Scaffold(
        appBar: AppBar(
          title: Text("Request History"),
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
                  title: Text("Request ID : ${services[index].id.toString()}"),
                  subtitle: Text("Type : ${get_service_type(services[index].type)}"),
                  trailing: Flex(
                    direction: Axis.vertical,
                    children: [
                      Text("Status : ${get_service_status(services[index].status)}"),
                      if (get_service_status(services[index].status) == 'ASSIGNED')
                        ElevatedButton(
                          onPressed: () async{
                            var service_state = serviceStates[services[index].id];
                            if (service_state.consumerStarted){
                              return;
                            }
                            service_state.consumerStarted = true;
                            var response = await API().put_service_state(service_state.toJson());
                            print(response);
                            serviceStates[services[index].id] = ServiceState.fromMap(response);
                            setState(() {
                              serviceStates = serviceStates;
                            });
                          },
                          child: Text("Approve Start"),
                        ),
                      if (get_service_status(services[index].status) == 'WORK IN PROGRESS')
                        ElevatedButton(
                          onPressed: () async{
                            var service_state = serviceStates[services[index].id];
                            if (service_state.consumerCompleted){
                              return;
                            }
                            service_state.consumerCompleted = true;
                            var response = await API().put_service_state(service_state.toJson());
                            print(response);
                            serviceStates[services[index].id] = ServiceState.fromMap(response);
                            setState(() {
                              serviceStates = serviceStates;
                            });
                          },
                          child: Text("Approve Complete"),
                        ),
                    ],
                  ),
                  tileColor: Colors.grey,
                );
              }
          ),
        ),
      );
    }else{
      return Text("LAODING");
    }
  }

}