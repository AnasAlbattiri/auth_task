import 'package:cloud_firestore/cloud_firestore.dart';

class Joined {
  String? name;
  String? uId;

  Joined(
      {required this.name,
        required this.uId,});

  Map<String, dynamic> toJson() => {
    "name": name,
    "uId": uId,
  };

  Joined.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
  }
}
