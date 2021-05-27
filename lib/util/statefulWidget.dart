import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/models/settings.dart';
import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:flutter_covid_dashboard_ui/models/user.dart';
import 'package:flutter_covid_dashboard_ui/util/auth.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_StateDataWidget>()
            as _StateDataWidget)
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  StateModel state;
  //GoogleSignInAccount googleAccount;
  //final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    //print('...initUser...');
    var firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    Bid365User user = await Auth.getUserLocal();
    Bid365Settings settings = await Auth.getSettingsLocal();
    var location = await Auth.getUserLocationLocal();
    String locationId = await Auth.getLocationIdLocal();
    String hoId = await Auth.gethoIdLocal();
    String soId = await Auth.getsoIdLocal();
    String soName = await Auth.getsoNameLocal();
    String hoName = await Auth.gethoNameLocal();
    String selPlayAtCategory = await Auth.getselPlayAtCategoryLocal();

    setState(() {
      state.isLoading = false;
      state.firebaseUserAuth = firebaseUserAuth;
      state.user = user;
      state.settings = settings;
      state.locationId = locationId;
      state.locationName = location;

      state.soId = soId;
      state.soName = soName;
      state.hoId = hoId;
      state.hoName = hoName;
      state.selPlayAtCategory = selPlayAtCategory;
    });
  }

  Future<void> userLocation(
      sname, dname, mname, vname, gsname, sId, dId, mId, vId, gsId) async {
    print('chec for this');
    //  await initUserLocation(location, locationId);
    // setState(() {
    //   state.locationId = locationId;
    //   state.locationName = location;
    //   state.soId = soId;
    //   state.soName = soName;
    //   state.hoId = hoId;
    //   state.hoName = hoName;
    //   state.stId = stId;
    //   state.stName = stName;
    // });
    // print('set location is ${location} so ${soName} ho== ${hoName}');
    await Auth.storeUserLocationLocal(
        sname, dname, mname, vname, gsname, sId, dId, mId, vId, gsId);
    await initUser();
  }

  Future<void> setSelLocatinContests(location) async {
    print('chec for this');
    //  await initUserLocation(location, locationId);
    setState(() {
      state.selPlayAtCategory = location;
    });
    await Auth.setSelPlayAtCategoryLocal(location);
    await initUser();
  }

  Future<void> logOutUser() async {
    await Auth.signOut();
    var firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    setState(() {
      state.user = null;
      state.settings = null;
      state.firebaseUserAuth = firebaseUserAuth;
    });
  }

  Future<void> resetPassword(email) async {
    await Auth.forgetPassword(email);
  }

  Future<void> logInUser(email, password) async {
    String userId = await Auth.signIn(email, password);
    print('am i called');
    Bid365User user = await Auth.getUserFirestore(userId);

    await Auth.getAndUpdateFcmToken(user, userId);
    await Auth.storeUserLocal(user);
    Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  localSaverTest(user, userId) async {
    await Auth.storeUserLocal(user);
    // Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    // await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  Future<void> fbLoginStoreUser(userId) async {
    Bid365User user = await Auth.getUserFirestore(userId);
    print('user is ${user}');
    await Auth.storeUserLocal(user);
    Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}
