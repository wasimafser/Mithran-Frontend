// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:collection';
import 'dart:convert';

User user;

class User {
  User({
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.password,
  });

  String firstName;
  dynamic lastName;
  String fullName;
  String email;
  String password;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
  );

  Map<String, dynamic> toMap() => {
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName,
    "full_name": fullName == null ? null : fullName,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
  };

  static set_user_instance(var data){
    print(data.runtimeType);
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
