// To parse this JSON data, do
//
//     final service = serviceFromMap(jsonString);

import 'dart:convert';

import 'package:mithran/data/profile.dart';

class Service {
  Service({
    this.id,
    this.assignedTo,
    this.requestedBy,
    this.requestedOn,
    this.comments,
    this.assignedOn,
    this.startedOn,
    this.completedOn,
    this.totalWorkTime,
    this.type,
    this.status,
  });

  int id;
  Profile assignedTo;
  Profile requestedBy;
  DateTime requestedOn;
  String comments;
  DateTime assignedOn;
  DateTime startedOn;
  DateTime completedOn;
  String totalWorkTime;
  int type;
  int status;

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    assignedTo: json["assigned_to"] == null ? null : Profile.fromMap(json["assigned_to"]),
    requestedBy: json["requested_by"] == null ? null : Profile.fromMap(json["requested_by"]),
    requestedOn: json["requested_on"] == null ? null : DateTime.parse(json["requested_on"]),
    comments: json["comments"] == null ? null : json["comments"],
    assignedOn: json["assigned_on"] == null ? null : DateTime.parse(json["assigned_on"]),
    startedOn: json["started_on"] == null ? null : DateTime.parse(json["started_on"]),
    completedOn: json["completed_on"] == null ? null : DateTime.parse(json["completed_on"]),
    totalWorkTime: json["total_work_time"] == null ? null : json["total_work_time"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "assigned_to": assignedTo == null ? null : assignedTo.toMap(),
    "requested_by": requestedBy == null ? null : requestedBy.toMap(),
    "requested_on": requestedOn == null ? null : requestedOn.toIso8601String(),
    "comments": comments == null ? null : comments,
    "assigned_on": assignedOn == null ? null : assignedOn.toIso8601String(),
    "started_on": startedOn == null ? null : startedOn.toIso8601String(),
    "completed_on": completedOn == null ? null : completedOn.toIso8601String(),
    "total_work_time": totalWorkTime == null ? null : totalWorkTime,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
  };
}

class _AssignedTo {
  _AssignedTo({
    this.user,
    this.contactNumber,
  });

  _User user;
  String contactNumber;

  factory _AssignedTo.fromJson(String str) => _AssignedTo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _AssignedTo.fromMap(Map<String, dynamic> json) => _AssignedTo(
    user: json["user"] == null ? null : _User.fromMap(json["user"]),
    contactNumber: json["contact_number"] == null ? null : json["contact_number"],
  );

  Map<String, dynamic> toMap() => {
    "user": user == null ? null : user.toMap(),
    "contact_number": contactNumber == null ? null : contactNumber,
  };
}

class _User {
  _User({
    this.fullName,
  });

  String fullName;

  factory _User.fromJson(String str) => _User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _User.fromMap(Map<String, dynamic> json) => _User(
    fullName: json["full_name"] == null ? null : json["full_name"],
  );

  Map<String, dynamic> toMap() => {
    "full_name": fullName == null ? null : fullName,
  };
}
