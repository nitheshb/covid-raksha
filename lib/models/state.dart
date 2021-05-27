import 'package:flutter_covid_dashboard_ui/models/settings.dart';
import 'package:flutter_covid_dashboard_ui/models/user.dart';

class StateModel {
  bool isLoading;
  var firebaseUserAuth;
  Bid365User user;
  Bid365Settings settings;
  String locationId, soId, hoId, stId;
  var sname, dname, mname, vname, gsname, sId, dId, mId, vId, gsId;
  var locationName;
  String  soName, hoName, stName, selPlayAtCategory;

  StateModel(
      {this.isLoading = false,
      this.firebaseUserAuth,
      this.user,
      this.settings,
      this.locationId = "0",
      this.locationName,
      this.selPlayAtCategory = "",
      this.sname = "",
      this.dname = "",
      this.mname = "",
      this.vname = "",
      this.gsname = "",
      this.sId = "",
      this.dId = "",
      this.mId = "",
      this.vId = "",
      this.gsId = ""});
}
