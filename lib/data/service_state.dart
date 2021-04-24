// To parse this JSON data, do
//
//     final serviceState = serviceStateFromMap(jsonString);

import 'dart:convert';

import 'package:mithran/tools/api.dart';

class ServiceState {
  ServiceState({
    this.id,
    this.consumerStarted,
    this.workerStarted,
    this.consumerCompleted,
    this.workerCompleted,
    this.service,
  });

  int id;
  bool consumerStarted;
  bool workerStarted;
  bool consumerCompleted;
  bool workerCompleted;
  int service;

  factory ServiceState.fromJson(String str) => ServiceState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceState.fromMap(Map<String, dynamic> json) => ServiceState(
    id: json["id"] == null ? null : json["id"],
    consumerStarted: json["consumer_started"] == null ? null : json["consumer_started"],
    workerStarted: json["worker_started"] == null ? null : json["worker_started"],
    consumerCompleted: json["consumer_completed"] == null ? null : json["consumer_completed"],
    workerCompleted: json["worker_completed"] == null ? null : json["worker_completed"],
    service: json["service"] == null ? null : json["service"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "consumer_started": consumerStarted == null ? null : consumerStarted,
    "worker_started": workerStarted == null ? null : workerStarted,
    "consumer_completed": consumerCompleted == null ? null : consumerCompleted,
    "worker_completed": workerCompleted == null ? null : workerCompleted,
    "service": service == null ? null : service,
  };

  static get_servicestate_instance(service_id) async{
    var tempServiceState = await API().get_service_state(service_id);
    ServiceState serviceState = ServiceState.fromMap(tempServiceState);
    return serviceState;
  }
}
