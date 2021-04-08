// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:collection';
import 'dart:convert';

User user;

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.password,
    this.type,
  });

  int id;
  String firstName;
  String lastName;
  String fullName;
  String email;
  String password;
  String type;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "full_name": fullName == null ? null : fullName,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "type": type == null ? null : type,
  };

  static set_user_instance(var data){
    // print(data.runtimeType);
    if (data.runtimeType == String){
      user = User.fromJson(data);
    }else{
      user = User.fromMap(data);
    }
  }

  static get_user_instance(){
    return user;
  }
}
