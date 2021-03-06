import 'package:flutter/material.dart';
import 'package:mithran/data/service.dart';
import 'package:mithran/data/service_state.dart';
import 'package:mithran/data/service_type.dart';
import 'package:mithran/tools/api.dart';
import 'package:mithran/tools/screen_size.dart';
import 'package:mithran/widgets/navigation_drawer.dart';

class ServiceDetails extends StatefulWidget{
  ServiceDetails({
    this.service
  });

  Service service;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ServiceDetailsState(service: service);
  }

}

class _ServiceDetailsState extends State<ServiceDetails>{
  _ServiceDetailsState({
    this.service
  });

  Service service;
  ServiceState serviceState;
  List serviceTypes = [];

  get_service_types() async{
    List tempServiceTypes = await API().get_service_types();
    tempServiceTypes.forEach((element) {
      serviceTypes.add(ServiceType.fromMap(element));
    });
    setState(() {
      serviceTypes = serviceTypes;
    });
  }

  get_service_state() async{
    serviceState = await ServiceState.get_servicestate_instance(service.id);
    setState(() {
      serviceState=serviceState;
    });
  }

  get_service_type(type_id){
    for (var value in serviceTypes) {
      if (value.id == type_id){
        return value.name;
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_service_types();
    get_service_state();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (service != null && serviceState != null){
      return Scaffold(
        appBar: AppBar(
          title: Text(service.id.toString()),
        ),
        drawer: NavigationDrawer(),
        body: Flex(
            direction: Axis.vertical,
          children: [
            Wrap(
              spacing: 2,
              children: [
                buildListTile("ID", service.id.toString()),
                buildListTile("Type", get_service_type(service.type)),
                buildListTile("Requested On", service.requestedOn.toString()),
                buildListTile("Requested By", service.requestedBy.user.fullName),
                buildListTile("Requestor Contact", service.requestedBy.contactNumber),
                buildListTile("Requestor Address", service.requestedBy.address),
                buildListTile("Comments", service.comments),
                if (serviceState.consumerStarted && serviceState.workerStarted == false)
                  ElevatedButton(
                      onPressed: () async{
                        if (serviceState.workerStarted){
                          return;
                        }
                        serviceState.workerStarted = true;
                        var response = await API().put_service_state(serviceState.toJson());
                        serviceState = ServiceState.fromMap(response);
                        setState(() {
                          serviceState = serviceState;
                        });
                      },
                      child: Text('Start')
                  ),
                if (serviceState.consumerStarted && serviceState.workerStarted && serviceState.consumerCompleted)
                  ElevatedButton(
                      onPressed: () async{
                        if (serviceState.workerCompleted){
                          return;
                        }
                        serviceState.workerCompleted = true;
                        var response = await API().put_service_state(serviceState.toJson());
                        serviceState = ServiceState.fromMap(response);
                        setState(() {
                          serviceState = serviceState;
                        });
                      },
                      child: Text('Complete')
                  ),
              ],
            )
          ],
        )
      );
    }else{
      return Text("LOADING");
    }
  }

  ListTile buildListTile(title, subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

}