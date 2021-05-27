import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbQuery {
  static DbQuery get instanace => DbQuery();
  StateModel appState;

  updateVolunteerDetails(
      uId, state, district, mandal, village, selSachivalayam) {
    print('am i hitteds , ${uId}');
    var body = {
      's': state,
      'd': district,
      'm': mandal,
      'v': village,
      'gs': selSachivalayam
    };

    var body1 = {"locDetails": body};
    FirebaseFirestore.instance.collection('users').doc(uId).update(body1);

    //return FirebaseFirestore.instance.collection('users').doc("3QGiO3DtfVPdCzsHLHd2bjf2wu43").update(body1);
  }

  createNewMedOrder(uId, formData, sname, dname, mname, vname, gsname, sId, dId,
      mId, vId, gsId, medType, sevirity) {
    print('am i hitteds , ${formData.aadharNo}');
    // state id

    var formData1 = {
      'name': formData.name,
      'phone': formData.phone,
      'aadharNo': formData.aadharNo,
      'age': formData.age,
      'sex': formData.sex,
      'oxoReading': formData.oxoReading,
      'covidStatus': formData.covidStatus,
      'healthStatus': formData.healthStatus,
      'otherHealthStaus': formData.otherHealthStaus,
      'effectedData': formData.effectedData,
      'vaccineDose': formData.vaccineDose,
      'vaccineType': formData.vaccineType,
    };

    var orderBody = {
      'pd': formData1,
      'cBy': uId,
      'vname': vname,
      'sevirity': sevirity,
      'med': medType,
      'status': 'open',
      'cD': DateTime.now().millisecondsSinceEpoch,
      'mId': mId
    };

    print('am i hitteds , ${orderBody}');
    // var body = {
    //   's': {state},
    //   'd': district,
    //   'm': mandal,
    //   'v': vname,
    //   'gs': selSachivalayam
    // };
    var sBody = {
      'totO': FieldValue.increment(1),
      "${medType.toLowerCase()}O": FieldValue.increment(1),
    };
    var dBody = {
      'totO': FieldValue.increment(1),
      "${medType.toLowerCase()}O": FieldValue.increment(1),
    };

    var mBody = {
      'totO': FieldValue.increment(1),
      "${medType.toLowerCase()}O": FieldValue.increment(1),
      '${vId}.totO': FieldValue.increment(1),
      '${vId}.${gsId}.totO': FieldValue.increment(1),
      '${vId}.${medType.toLowerCase()}O': FieldValue.increment(1),
      '${vId}.${gsId}.${medType.toLowerCase()}O': FieldValue.increment(1)
    };

    // state
    // totO, totS, totD, nO, pO, lO, fO, dO,  nD, pD, lD, fD, dD,
    //  district
    // totO, totS, totD,  nO, pO, lO, fO, dO,  nD, pD, lD, fD, dD,
    //  mandal
    // totO, totS, totD,  nO, pO, lO, fO, dO,  nD, pD, lD, fD, dD,
    //  village
    // totO, totS, totD,  nO, pO, lO, fO, dO,  nD, pD, lD, fD, dD,
    //  gs
    // totO, totS, totD,  nO, pO, lO, fO, dO,  nD, pD, lD, fD, dD,
    var voluntBody = {
      'medStats': {
        'totO': FieldValue.increment(3),
        "${medType.toLowerCase()}O": FieldValue.increment(2),
        "lO":FieldValue.increment(1)
        
      }
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc("${uId}")
        .update(voluntBody);

    FirebaseFirestore.instance
        .collection('medOrders')
        .doc("${formData.aadharNo}")
        .set(orderBody);
    FirebaseFirestore.instance
        .collection('medOrdersStats')
        .doc("${sId}")
        .update(sBody);
    FirebaseFirestore.instance
        .collection('medOrdersStats')
        .doc("${dId}")
        .update(dBody);
    FirebaseFirestore.instance
        .collection('medOrdersStats')
        .doc("${mId}")
        .update(mBody);
    // FirebaseFirestore.instance.collection('medOrders').doc("${vId}").update(body1);

    //return FirebaseFirestore.instance.collection('users').doc("3QGiO3DtfVPdCzsHLHd2bjf2wu43").update(body1);
  }

  createContestFromTemplate(tableName, templatePayload, locationId,
      locationName, cID, uId, matchId) async {
    templatePayload['template'] = false;
    templatePayload['freeze'] = false;
    templatePayload['areaCode'] = [locationId];
    templatePayload['areaId'] = locationId;
    templatePayload['areaName'] = locationName;
    templatePayload['tId'] = cID;
    templatePayload['cId'] = cID;
    templatePayload['cOpen'] = true;
    templatePayload['cBy'] = uId;
    templatePayload['matchId'] = matchId;
    print('iwas here for contest creation ');
// table name is between TodayFixtures  or matchId_rebel_cc
    var d = await FirebaseFirestore.instance
        .collection(tableName)
        .doc()
        .set(templatePayload)
        .then((value) => print('contest is created'));
    //  print('value is ${d}');
  }

  enterMatchStats(
      tableName, templatePayload, locationId, locationName, cID, uId, matchId) {
    var td = templatePayload;
    var maxPlayers;
    var prize1;
    var statsBody;
    if (cID == 'Friends') {
      print('ami hitted1');
      try {
        maxPlayers = int.parse(td['max_players']);
      } catch (e) {
        print('errro si ${e}');
        maxPlayers = 0;
      }

      try {
        prize1 = td['prizeAmount'];
      } catch (e) {
        print('errro si 1 ${e}');

        prize1 = 0;
      }
      statsBody = {
        'overallCC': FieldValue.increment(1),
        'friendsC': FieldValue.increment(1),
        'tfriendsSpots': FieldValue.increment(maxPlayers),
        'totalMSpotsCreated': FieldValue.increment(maxPlayers),
        'TotalPrize': FieldValue.increment(prize1),
        'tfriendsPrize': FieldValue.increment(prize1),
        'tMSpotsF': FieldValue.increment(1),
        'tfriendsSpotsF': FieldValue.increment(1),
      };
    } else {
      try {
        maxPlayers = int.parse(td['max_players']);
      } catch (e) {
        print('errro si ${e}');
        maxPlayers = 0;
      }

      try {
        prize1 = int.parse(td['prizeAmount']);
      } catch (e) {
        print('errro si 1 ${e}');

        prize1 = 0;
      }

      if (td['locationMode'] == "Mandal") {
        statsBody = {
          'overallCC': FieldValue.increment(1),
          'subZoneC': FieldValue.increment(1),
          'tsubZoneSpots': FieldValue.increment(maxPlayers),
          'totalMSpotsCreated': FieldValue.increment(maxPlayers),
          'TotalPrize': FieldValue.increment(prize1),
          'tsubZonePrize': FieldValue.increment(prize1),
          'tMSpotsF': FieldValue.increment(maxPlayers),
          'tsubZoneSpotsF': FieldValue.increment(maxPlayers),
        };
      } else if (td['locationMode'] == "State") {
        statsBody = {
          'overallCC': FieldValue.increment(1),
          'ZoneC': FieldValue.increment(1),
          'tZoneSpots': FieldValue.increment(maxPlayers),
          'totalMSpotsCreated': FieldValue.increment(maxPlayers),
          'TotalPrize': FieldValue.increment(prize1),
          'tZonePrize': FieldValue.increment(prize1),
          'tMSpotsF': FieldValue.increment(maxPlayers),
          'tZoneSpotsF': FieldValue.increment(maxPlayers),
        };
      }
    }
    FirebaseFirestore.instance
        .collection("Stats")
        .doc(matchId)
        .update(statsBody)
        .then((doc) {
      print("savedTEamsCounter");
    });
  }

  getFriendsContest(tableName, contestDocId) {
    return FirebaseFirestore.instance
        .collection(tableName)
        .where("cId", isEqualTo: contestDocId)
        .snapshots();
    //  print('value is ${d}');
  }

  createFriendsContestFromTemplate(tableName, matchId, templatePayload,
      locationId, locationName, cID, uId) async {
    templatePayload['template'] = false;
    templatePayload['freeze'] = false;
    templatePayload['areaCode'] = [locationId];
    templatePayload['areaId'] = locationId;
    templatePayload['areaName'] = locationName;
    templatePayload['tId'] = cID;
    templatePayload['cId'] = cID;
    templatePayload['cOpen'] = true;
    templatePayload['cBy'] = uId;
    templatePayload['matchId'] = matchId;
    print('iwas here for contest creation ');
// table name is between TodayFixtures  or matchId_rebel_cc
    var d = await FirebaseFirestore.instance
        .collection(tableName)
        .doc()
        .set(templatePayload)
        .then((value) => print('contest is created'));
    //  print('value is ${d}');
    //
    print('ami hitted');
    enterMatchStats(tableName, templatePayload, locationId, locationName,
        'Friends', uId, matchId);
  }

//  home page query
  getMatches(_country) {
    return FirebaseFirestore.instance
        .collection(_country)
        .where("status", isEqualTo: 'Showing')
        .snapshots();
  }

  getSeries(selSport) {
    return FirebaseFirestore.instance
        .collection(selSport + "M")
        .where("status", isEqualTo: 'Showing')
        .where("type", isEqualTo: 'series')
        .snapshots();
  }

  getContestTemplate(matchId) {
    return FirebaseFirestore.instance
        .collection('contestTemplatesNew')
        .where("matchID", isEqualTo: matchId)
        .snapshots();
  }

  getContestDataTypeAll(matchId) {
    return FirebaseFirestore.instance
        .collection('TodayFixtures')
        .where(
          "matchId",
          isEqualTo: matchId,
        )
        .where(
          "cOpen",
          isEqualTo: true,
        )
        .where(
          "locationMode",
          isEqualTo: "All",
        )
        .snapshots();
  }

  getLiveContests(pListId, locId, matchId) {
    print('pid are ${pListId}');
    return FirebaseFirestore.instance
        .collection('TodayFixtures')
        .where('tId', isEqualTo: pListId.toString())
        // .where('areaId',isEqualTo: 524)
        .where("areaCode", arrayContainsAny: locId)
        .where("cOpen", isEqualTo: true)
        .where("matchId", isEqualTo: matchId)
        .snapshots();
  }

  getSavedTeams(selSport_ST, emailId, matchId) {
    return FirebaseFirestore.instance
        .collection(selSport_ST + "savT")
        .where("matchID", isEqualTo: matchId)
        .where("email", isEqualTo: emailId)
        .snapshots();
  }

  getLiveContestLeadership(contestTableName, contestDocId) {
    print('tableName ${contestTableName} ${contestDocId}');
    return FirebaseFirestore.instance
        .collection(contestTableName)
        .doc(contestDocId)
        .snapshots();
  }

  getLOCATIONLeadership(id) {
    return FirebaseFirestore.instance
        .collection('LocLeader')
        .doc(id)
        .snapshots();
  }

  getMatcheContests(selSport, status, userId) {
    if (status == 'temp') {
      return FirebaseFirestore.instance
          .collection(selSport + "M")
          .where("temp", isEqualTo: status)
          .snapshots();
    } else {
      print('iam here for showing ${status == 'Showing'}');
      // this is today lives matches list
      return FirebaseFirestore.instance
          .collection(selSport + "M")
          .where("status", isEqualTo: status)
          .snapshots();
    }
  }

  Stream<DocumentSnapshot> SteamData(userId) {
    print('what is this scrap $userId');
    if (userId == '') {
      print('what is this scrap1 $userId');
      userId = FirebaseAuth.instance.currentUser.uid;
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  getRebelMatches(matchId, docId) {
    return FirebaseFirestore.instance
        .collection('${matchId}_RC')
        .doc(docId)
        .snapshots();
  }

  getLiveScore(selSport, matchId) {
    return FirebaseFirestore.instance
        .collection(selSport + "M")
        .doc(matchId)
        .snapshots();
  }

  getParticipantMatches(userId, matchId, selSport) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('${selSport}S')
        .where('matchId', isEqualTo: matchId.toString())
        .snapshots();
  }

  updateLocationDetails(uId, index, locationName, locatonId) {
    print('am i hitteds , ${uId}');
    var playingPlacesNames;
    if (index == 1) {
      playingPlacesNames = [locationName, '', ''];
    }
    var body = {
      'p${index}_Name': locationName,
      'p${index}_Id': locatonId,
      'p${index}_winC': 0,
      'p${index}_tC': 0,
      'p${index}_money_spend': 0,
      'p${index}_tier_points': 0,
      'playingPlacesNames': FieldValue.arrayUnion([locationName]),
      'playingPlaceId': FieldValue.arrayUnion([locatonId]),
    };

    var body1 = {
      'locationData': {
        'p${index}_Name': 'testName1',
        'p${index}_Id': locatonId,
        'p${index}_tC': FieldValue.increment(20),
      }
    };

    FirebaseFirestore.instance
        .collection('users')
        .where('locationData.pindex_Id', isEqualTo: 'locatonId')
        .orderBy('locationData.pindex_tC', descending: true)
        .limit(3)
        .get()
        .then((value) => print('value is ${value.docs[0].data()}'));
    //return FirebaseFirestore.instance.collection('users').doc("3QGiO3DtfVPdCzsHLHd2bjf2wu43").update(body1);
  }

  updateRebelMatchCount(
    userId,
  ) async {
    var userLocRef = FirebaseFirestore.instance
        .collection('FriendsMatchesCount')
        .doc('199347_RC');
//   TC= total games Count, MS=money spend,  TP = tier points , LpT = last payedTime
    var locationDetails = {
      // 'WC_$locatonId': FieldValue.increment(1),
      'RC_count': FieldValue.increment(1),
    };
    var x = await userLocRef.get();
    if (x.exists) {
      print('value is ####### ${x.data()['RC_count']}');
      var c = x.data()['RC_count'] + 1;
      userLocRef.update(locationDetails);
      return c;
    } else {
      userLocRef.set(locationDetails);
      return 1;
    }
  }

  updateReferalIdCount(
    userId,
  ) async {
    var userLocRef =
        FirebaseFirestore.instance.collection('ReferCode').doc('199347_RC');
//   TC= total games Count, MS=money spend,  TP = tier points , LpT = last payedTime
    var locationDetails = {
      // 'WC_$locatonId': FieldValue.increment(1),
      'Refer_count': FieldValue.increment(1),
    };
    var x = await userLocRef.get();
    if (x.exists) {
      print('value is ####### ${x.data()['Refer_count']}');
      var c = x.data()['Refer_count'] + 1;
      userLocRef.update(locationDetails);
      return c;
    } else {
      userLocRef.set(locationDetails);
      return 1;
    }
  }

  updateUserLocationDetails(userId, locatonId, locationName, moneySpend) {
    var userLocRef =
        FirebaseFirestore.instance.collection('Location').doc(userId);
//   TC= total games Count, MS=money spend,  TP = tier points , LpT = last payedTime
    var locationDetails = {
      'N_$locatonId': locationName,
      'Id_$locatonId': locatonId,
      // 'WC_$locatonId': FieldValue.increment(1),
      'TC_$locatonId': FieldValue.increment(1),
      'MS_$locatonId': FieldValue.increment(moneySpend),
      // 'TP_$locatonId': 0,
      'LPT_$locatonId': DateTime.now().millisecondsSinceEpoch,
      'playingPlacesNames': FieldValue.arrayUnion([locationName]),
      'playingPlaceId': FieldValue.arrayUnion([locatonId]),
    };

    userLocRef.get().then((docSnapshot) => {
          if (docSnapshot.exists)
            {userLocRef.update(locationDetails)}
          else
            {
              userLocRef.set(locationDetails)
              // create the document
            }
        });
  }

  scratchCardDbQuery(docId, uId, value) {
    FirebaseFirestore.instance
        .doc("ScratchCards/${docId}")
        .update({"status": "claimed"});
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((docSnap) {
      var newRewardPoints = 0;
      if (docSnap.data().containsKey("rewardPoints")) {
        print('inside RewardPoints');
        newRewardPoints = docSnap["rewardPoints"] + value;
      } else {
        print('inside RewardPoints nope');
        newRewardPoints = value;
      }
      FirebaseFirestore.instance
          .doc("users/${uId}")
          .update({"rewardPoints": newRewardPoints});
    });
  }

  getUserDetails(userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  getReferedUserDetails(referId) async {
    QuerySnapshot docs = await FirebaseFirestore.instance
        .collection('users')
        .where("myRCode", isEqualTo: referId)
        .get();

    if (!docs.docs.isEmpty) {
      return docs.docs[0].id;
    } else {
      return null;
    }
  }

  checkIfDispNameExists(name) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("dispName", isEqualTo: name)
        .get();
  }

  Future<void> updateUserToken(userID, token, oldToken) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'FCMToken': token,
    });
  }

// KYC
  getKycDetails(userId) {
    return FirebaseFirestore.instance.collection('Kyc').doc(userId).snapshots();
  }

  updateKycEmailidStatus(userId, status, emailPhone, type) {
    var usersRef = FirebaseFirestore.instance.collection('Kyc').doc(userId);
    var body;
    if (type == "email") {
      body = {
        'emailIdStatus': status,
        'emailId': emailPhone,
        'emailVdate': DateTime.now().millisecondsSinceEpoch
      };
    } else if (type == "phone") {
      body = {
        'phoneStatus': status,
        'phoneNo': emailPhone,
        'phoneVdate': DateTime.now().millisecondsSinceEpoch
      };
    } else if (type == "panCard") {
      body = emailPhone;
    }

    usersRef.get().then((docSnapshot) => {
          if (docSnapshot.exists)
            {usersRef.update(body)}
          else
            {
              usersRef.set(body)
// create the document
            }
        });
    print('email is ${userId}');
  }

  createCompliant(category, phNo, desc, email, uID) {
    var body = {
      'type': category,
      'contact': phNo,
      'email': email,
      'uId': uID,
      'details': category,
      'status': 'open',
      'cOn': DateTime.now().millisecondsSinceEpoch
    };
    return FirebaseFirestore.instance.collection('Compliants').doc().set(body);
  }
//  getKycDetails(userId) async {
//    print('inside kyc fetch');
//   return   FirebaseFirestore.instance.collection('Kyc').doc(userId).snapshots();

//   //     kycData = x.data.containsKey("pancardLock") ? x.data['pancardLock'] : false;
//   //     panNameController.text = x.data.containsKey("pancard_holder_name") ? x.data['pancard_holder_name'] :'';
//   //     panNoController.text = x.data.containsKey("pancardNo") ? x.data['pancardNo'] :'';

//   //  print('featcheed details are ${x.data.containsKey("pancardNo") ? x.data['pancardNo'] :''}');
//   }

  cloneTeamF(selSport, oldTeam, teamCount, uId, matchId) async {
    //print("match id fromm capVapSet ${widget.matchId}");

    var counterDocId = uId + matchId;
    print("doc checker $counterDocId");
    final collRef = FirebaseFirestore.instance.collection(selSport + "savT");
    DocumentReference docReferance = collRef.doc();
    return docReferance.set(oldTeam).then((doc) {
      var newTeamID = docReferance.id;
      // saving  id in same doc for resave help
      FirebaseFirestore.instance
          .collection(selSport + "savT")
          .doc(newTeamID)
          .update({"fanTeamId": docReferance.id});
      FirebaseFirestore.instance
          .collection("savedTeamsCounter")
          .doc(counterDocId)
          .update({'count': (0 + 1)}).then((doc) {
        print("savedTEamsCounter");
      });

      print('hop ${docReferance.id}');
      // return docReferance.id;
    });
  }

  deleteTeam(selSport, teamId, teamCount, uId, matchId) {
    var counterDocId = uId + matchId;
    FirebaseFirestore.instance
        .collection(selSport + "savT")
        .doc(teamId)
        .delete();
    FirebaseFirestore.instance
        .collection("savedTeamsCounter")
        .doc(counterDocId)
        .update({'count': (teamCount - 1)})
        .then((doc) {})
        .catchError((error) {
          print("error at decrementing the counter value");
        });
  }

  createTransactionLog(type, transactionAmount, uID, payload, wa, da, cb) {
    var transactions = {
      "uid": uID,
      "wa": wa,
      "da": da,
      "cb": cb,
      "payload": payload,
      "date": DateTime.now().millisecondsSinceEpoch,
      "transactionAmount": transactionAmount,
      "type": type
    };
    return FirebaseFirestore.instance
        .collection('Transactions')
        .doc()
        .set(transactions);
  }

  getUserTransactions(uid) {
    return FirebaseFirestore.instance
        .collection('Transactions')
        .where("uid", isEqualTo: uid)
        .orderBy('date')
        .limitToLast(10)
        .snapshots();
  }
}
