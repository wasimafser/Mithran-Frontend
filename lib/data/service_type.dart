// To parse this JSON data, do
//
//     final serviceType = serviceTypeFromMap(jsonString);

import 'dart:convert';

class ServiceType {
  ServiceType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ServiceType.fromJson(String str) => ServiceType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceType.fromMap(Map<String, dynamic> json) => ServiceType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
