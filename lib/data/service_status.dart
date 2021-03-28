// To parse this JSON data, do
//
//     final serviceType = serviceTypeFromMap(jsonString);

import 'dart:convert';

class ServiceStatus {
  ServiceStatus({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ServiceStatus.fromJson(String str) => ServiceStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceStatus.fromMap(Map<String, dynamic> json) => ServiceStatus(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
