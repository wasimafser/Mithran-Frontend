// To parse this JSON data, do
//
//     final serviceFeedback = serviceFeedbackFromMap(jsonString);

import 'dart:convert';

class ServiceFeedback {
  ServiceFeedback({
    this.id,
    this.rating,
    this.comment,
    this.service,
  });

  int id;
  int rating;
  String comment;
  int service;

  factory ServiceFeedback.fromJson(String str) => ServiceFeedback.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceFeedback.fromMap(Map<String, dynamic> json) => ServiceFeedback(
    id: json["id"] == null ? null : json["id"],
    rating: json["rating"] == null ? null : json["rating"],
    comment: json["comment"] == null ? null : json["comment"],
    service: json["service"] == null ? null : json["service"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "rating": rating == null ? null : rating,
    "comment": comment == null ? null : comment,
    "service": service == null ? null : service,
  };
}
