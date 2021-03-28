// To parse this JSON data, do
//
//     final consumer = consumerFromMap(jsonString);

import 'dart:convert';

import 'package:mithran/tools/api.dart';
import 'package:mithran/user.dart';

Consumer consumer;

class Consumer {
  Consumer({
    this.id,
    this.contactNumber,
    this.alternateContactNumber,
    this.doorNumber,
    this.address,
    this.user,
    this.organization,
  });

  int id;
  String contactNumber;
  dynamic alternateContactNumber;
  String doorNumber;
  String address;
  int user;
  String organization;

  factory Consumer.fromJson(String str) => Consumer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Consumer.fromMap(Map<String, dynamic> json) => Consumer(
    id: json["id"] == null ? null : json['id'],
    contactNumber: json["contact_number"] == null ? null : json['contact_number'],
    alternateContactNumber: json["alternate_contact_number"] == null ? null : json['alternate_contact_number'],
    doorNumber: json["door_number"] == null ? null : json['door_number'],
    address: json["address"] == null ? null : json['address'],
    user: json["user"] == null ? null : json['user'],
    organization: json["organization"] == null ? null : json["organization"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "contact_number": contactNumber,
    "alternate_contact_number": alternateContactNumber,
    "door_number": doorNumber,
    "address": address,
    "user": user,
    "organization": organization
  };

  static set_consumer_instance(var data){
    // print(data.runtimeType);
    if (data.runtimeType == String){
      consumer = Consumer.fromJson(data);
    }else{
      consumer = Consumer.fromMap(data);
    }
    return consumer;
  }

  static get_consumer_instance(){
    if ( consumer == null ){
      return _fetch_consumer();
    }
    return consumer;
  }
}

_fetch_consumer() async{
  User user = User.get_user_instance();
  return Consumer.set_consumer_instance(await API().get_consumer(user.id));
}