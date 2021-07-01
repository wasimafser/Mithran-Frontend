// To parse this JSON data, do
//
//     final report = reportFromMap(jsonString);

import 'dart:convert';

class Report {
  Report({
    this.userId,
    this.fullName,
    this.totalServices,
    this.totalWorkTime,
  });

  int userId;
  String fullName;
  int totalServices;
  String totalWorkTime;

  factory Report.fromJson(String str) => Report.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Report.fromMap(Map<String, dynamic> json) => Report(
    userId: json["user_id"] == null ? null : json["user_id"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    totalServices: json["total_services"] == null ? null : json["total_services"],
    totalWorkTime: json["total_work_time"] == null ? null : json["total_work_time"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId == null ? null : fullName,
    "full_name": fullName == null ? null : fullName,
    "total_services": totalServices == null ? null : totalServices,
    "total_work_time": totalWorkTime == null ? null : totalWorkTime,
  };
}
