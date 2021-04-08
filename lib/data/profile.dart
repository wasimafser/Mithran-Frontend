// To parse this JSON data, do
//
//     final profile = profileFromMap(jsonString);

import 'dart:convert';

import 'package:mithran/tools/api.dart';
import 'package:mithran/user.dart';

Profile profile;

class Profile {
  Profile({
    this.id,
    this.organization,
    this.contactNumber,
    this.alternateContactNumber,
    this.doorNumber,
    this.address,
    this.user,
    this.specializations,
  });

  int id;
  String organization;
  String contactNumber;
  dynamic alternateContactNumber;
  String doorNumber;
  String address;
  User user;
  List<dynamic> specializations;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    id: json["id"] == null ? null : json["id"],
    organization: json["organization"] == null ? null : json["organization"],
    contactNumber: json["contact_number"] == null ? null : json["contact_number"],
    alternateContactNumber: json["alternate_contact_number"],
    doorNumber: json["door_number"] == null ? null : json["door_number"],
    address: json["address"] == null ? null : json["address"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    specializations: json["specializations"] == null ? null : List<dynamic>.from(json["specializations"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "organization": organization == null ? null : organization,
    "contact_number": contactNumber == null ? null : contactNumber,
    "alternate_contact_number": alternateContactNumber,
    "door_number": doorNumber == null ? null : doorNumber,
    "address": address == null ? null : address,
    "user": user == null ? null : user.toMap(),
    "specializations": specializations == null ? null : List<dynamic>.from(specializations.map((x) => x)),
  };

  static set_profile_instance(data){
    if (data.runtimeType == String){
      profile = Profile.fromJson(data);
    }else{
      profile = Profile.fromMap(data);
    }
    return profile;
  }

  static get_profile_instance(){
    if (profile == null){
      return _fetch_profile();
    }
    return profile;
  }
}

_fetch_profile() async{
  User user = User.get_user_instance();
  return Profile.set_profile_instance(await API().get_profile(user.id));
}