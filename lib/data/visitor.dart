// To parse this JSON data, do
//
//     final visitor = visitorFromMap(jsonString);

import 'dart:convert';

class Visitor {
  Visitor({
    this.id,
    this.fullName,
    this.contactNumber,
    this.inTime,
    this.outTime,
    this.visiting,
  });

  int id;
  String fullName;
  String contactNumber;
  DateTime inTime;
  DateTime outTime;
  int visiting;

  factory Visitor.fromJson(String str) => Visitor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Visitor.fromMap(Map<String, dynamic> json) => Visitor(
    id: json["id"] == null ? null : json["id"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    contactNumber: json["contact_number"] == null ? null : json["contact_number"],
    inTime: json["in_time"] == null ? null : DateTime.parse(json["in_time"]),
    outTime: json["out_time"] == null ? null : DateTime.parse(json["out_time"]),
    visiting: json["visiting"] == null ? null : json["visiting"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "full_name": fullName == null ? null : fullName,
    "contact_number": contactNumber == null ? null : contactNumber,
    "in_time": inTime == null ? null : inTime.toIso8601String(),
    "out_time": outTime == null ? null : outTime.toIso8601String(),
    "visiting": visiting == null ? null : visiting,
  };
}
