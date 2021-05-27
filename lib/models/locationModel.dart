import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

LocationModel userFromJson(String str) {
  final jsonData = json.decode(str);
  return LocationModel.fromJson(jsonData);
}

String userToJson(LocationModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LocationModel {
 String sname,
        dname,
        mname,
        vname,
        gsname,
        sId,
        dId,
        mId,
        vId,
        gsId;

  LocationModel(
      {this.sname,
        this.dname,
        this.mname,
        this.vname,
        this.gsname,
        this.sId,
        this.dId,
        this.mId,
        this.vId,
        this.gsId});

  factory LocationModel.fromJson(Map<String, dynamic> json) => new LocationModel(
      sname: json["sname"],
      dname: json['dname'],
      mname: json["mname"],
      vname: json["vname"],
      gsname: json["gsname"],
      sId: json["sId"],
      dId: json["dId"],
      mId: json["mId"],
      vId: json["vId"],
      gsId: json["gsId"],
      );

  Map<String, dynamic> toJson() => {
        "sname": sname,
        "dname": dname,
        "mname": mname,
        "vname": vname,
        "gsname": gsname,
        "sId": sId,
        "dId": dId,
        "mId": mId,
        "vId": vId,
        "gsId": gsId,
      };

  factory LocationModel.fromDocument(DocumentSnapshot doc) {
    return LocationModel.fromJson(doc.data());
  }
}
