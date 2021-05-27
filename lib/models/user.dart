import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

Bid365User userFromJson(String str) {
  final jsonData = json.decode(str);
  return Bid365User.fromJson(jsonData);
}

String userToJson(Bid365User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Bid365User {
  String userId;
  String dispName;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String referralCode;
  var walletMoney, deposits, winnings;
  var CompletedGames, LiveGames;
  String location;
  int winCount, winC, totalC, drawC, winSC;
  String season;
  List placeLock, liveAt;
  List playingPlaces, playingPlacesNames, playingPlaceId, FriendsList;

  Bid365User(
      {this.userId,
      this.dispName,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.referralCode,
      this.walletMoney,
      this.location,
      this.deposits,
      this.winnings,
      this.CompletedGames,
      this.LiveGames,
      this.winCount,
      this.winC,
      this.totalC,
      this.drawC,
      this.winSC,
      this.liveAt,
      this.placeLock,
      this.playingPlaces,
      this.playingPlacesNames,
      this.playingPlaceId,
      this.FriendsList,
      this.season});

  factory Bid365User.fromJson(Map<String, dynamic> json) => new Bid365User(
      userId: json["userId"],
      dispName: json['dispName'],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phoneNumber: json["phoneNumber"],
      referralCode: json["referralCode"],
      email: json["email"],
      location: json["location"],
      deposits: json["deposits"],
      winnings: json["winnings"],
      CompletedGames: json["CompletedGames"],
      LiveGames: json["LiveGames"],
      winC: json['winC'],
      totalC: json['totalC'],
      drawC: json['drawC'],
      playingPlacesNames: json['playingPlacesNames'],
      playingPlaceId: json['playingPlaceId'],
      placeLock: json['placeLock'],
      winSC: json['winSC'],
      liveAt: json['liveAt'],
      FriendsList: json['FriendsList'],
      season: json['season']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "dispName": dispName,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "referralCode": referralCode,
        "email": email,
        "walletMoney": walletMoney,
        "location": location,
        "deposits": deposits,
        "winnings": winnings,
        "CompletedGames": CompletedGames,
        "LiveGames": LiveGames,
        "winC": winC,
        "totalC": totalC,
        "drawC": drawC,
        "playingPlacesNames": playingPlacesNames,
        "playingPlaceId": playingPlaceId,
        "placeLock": placeLock,
        "winSC": winSC,
        "liveAt": liveAt,
        "FriendsList": FriendsList,
        "season": season
      };

  factory Bid365User.fromDocument(DocumentSnapshot doc) {
    return Bid365User.fromJson(doc.data());
  }
}
