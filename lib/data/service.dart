// To parse this JSON data, do
//
//     final service = serviceFromMap(jsonString);

import 'dart:convert';

class Service {
  Service({
    this.id,
    this.assignedTo,
    this.requestedOn,
    this.comments,
    this.requestedBy,
    this.type,
    this.status,
  });

  int id;
  AssignedTo assignedTo;
  DateTime requestedOn;
  String comments;
  int requestedBy;
  int type;
  int status;

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["id"],
    assignedTo: AssignedTo.fromMap(json["assigned_to"]),
    requestedOn: DateTime.parse(json["requested_on"]),
    comments: json["comments"],
    requestedBy: json["requested_by"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "assigned_to": assignedTo == null ? null : assignedTo.toMap(),
    "requested_on": requestedOn == null ? null : requestedOn.toIso8601String(),
    "comments": comments,
    "requested_by": requestedBy,
    "type": type,
    "status": status == null ? null : status,
  };
}

class AssignedTo {
  AssignedTo({
    this.user,
    this.contactNumber,
  });

  _User user;
  String contactNumber;

  factory AssignedTo.fromJson(String str) => AssignedTo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignedTo.fromMap(Map<String, dynamic> json) => AssignedTo(
    user: _User.fromMap(json["user"]),
    contactNumber: json["contact_number"],
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
    fullName: json["full_name"],
  );

  Map<String, dynamic> toMap() => {
    "full_name": fullName == null ? null : fullName,
  };
}
