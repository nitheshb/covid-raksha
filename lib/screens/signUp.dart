import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_dashboard_ui/models/user.dart';
import 'package:flutter_covid_dashboard_ui/screens/locationSel.dart';
import 'package:flutter_covid_dashboard_ui/screens/signIn.dart';
import 'package:flutter_covid_dashboard_ui/themeFile.dart';
import 'package:flutter_covid_dashboard_ui/util/auth.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:flutter_covid_dashboard_ui/util/firebaseQueries.dart';
import 'package:flutter_covid_dashboard_ui/util/formValidator.dart';
import 'package:flutter_covid_dashboard_ui/util/loadingScreen.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:get/get.dart';



class Signup extends StatefulWidget {
  Signup({
    Key key,
    @required this.userInfo,
  }) : super(key: key);
  var userInfo;
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _displayName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _referralCode = new TextEditingController();


  String dispNameExists;
  bool loading = true;

  bool _autoValidate = false;
  bool _loadingVisible = false;
  var W;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp(
      {String dispName,
      String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String password,
      String referralCode,
      String region,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      print('inside form submit this');
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.

        await Auth.signUp(email, password).then((uID) async {
          await Auth.addUserSettingsDB(
              context,
              new Bid365User(
                // userId: widget.userInfo.user.uid,
                // phoneNumber: widget.userInfo.user.phoneNumber,
                // email: widget.userInfo.user.email,
                // firstName: widget.userInfo.user.displayName,
                // lastName: widget.userInfo.user.displayName,
                userId: uID,
                dispName: dispName,
                phoneNumber: phoneNumber,
                email: email,
                firstName: '',
                lastName: '',
                referralCode: referralCode,
                walletMoney: 50,
                location: '',
                deposits: 0,
                winnings: 0,
                winC: 0,
                totalC: 0,
                drawC: 0,
                playingPlacesNames: [],
                playingPlaceId: [],
                placeLock: [false, false, false],
                winSC: 0,
                liveAt: [],
                CompletedGames: [],
                LiveGames: [],
                FriendsList: [],
                season: '21Y-1',
              ));
          await Auth.localSaveDispName(dispName);
          await StateWidget.of(context).localSaverTest(
              new Bid365User(
                // userId: widget.userInfo.user.uid,
                // phoneNumber: widget.userInfo.user.phoneNumber,
                // email: widget.userInfo.user.email,
                // firstName: widget.userInfo.user.displayName,
                // lastName: widget.userInfo.user.displayName,
                userId: uID,
                dispName: dispName,
                phoneNumber: phoneNumber,
                email: email,
                firstName: '',
                lastName: '',
                referralCode: referralCode,
                walletMoney: 50,
                location: '',
                deposits: 0,
                winnings: 0,
                winC: 0,
                totalC: 0,
                drawC: 0,
                playingPlacesNames: [],
                playingPlaceId: [],
                placeLock: [false, false, false],
                winSC: 0,
                liveAt: [],
                CompletedGames: [],
                LiveGames: [],
                FriendsList: [],
                season: '21Y-1',
              ),
              uID);
        });

//
        //   Auth.addUserSettingsDB(context, new Bid365User(
        //   userId: widget.userInfo.user.uid,
        //   phoneNumber: widget.userInfo.user.phoneNumber,
        //   email: widget.userInfo.user.email,
        //   firstName: widget.userInfo.user.displayName,
        //   lastName: widget.userInfo.user.displayName,
        //   // referralCode: referralCode,
        //   walletMoney: 50,
        //   location: '',
        //   deposits: 0,
        //   winnings: 0,
        //   winC: 0,
        //   totalC: 0,
        //   drawC: 0,
        //   playingPlacesNames: [],
        //   playingPlaceId: [],
        //   placeLock: [false, false, false],
        //   winSC: 0,
        //   liveAt: [],

        //   CompletedGames: [],
        //   LiveGames: [],
        //   FriendsList:[],
        //   season: '21Y-1',

        // ));

        //now automatically login user too

        await Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (BuildContext context) => SetLocation(),
            ),
            (Route<dynamic> route) => false);
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        String exception = Auth.getExceptionText(e);
        Get.snackbar(
          "ERROR:  ${exception}", // title
          "", // message
          icon: Icon(Icons.error),
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          duration: Duration(seconds: 12),
        );
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    W = screenSize.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.greenAccent[200],
                    Colors.blueAccent[200]], tileMode: TileMode.clamp,),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: W / 19.2, top: W / 12.8, bottom: W / 9.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(
                              width: W / 3.45,
                              height: W / 3.45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/icon/rdx.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'SIGNUP',
                                style: Bid365AppTheme.ksuperHeading
                                    .copyWith(color: textColorB, fontSize: 30),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: W / 19.2),
                                child: Text(
                                  'LOGIN',
                                  style: Bid365AppTheme.h1B.copyWith(
                                    color: textColorB,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

//                    SizedBox(height: 5.0),
//                    Text('No commitments or long-term contracts.',
//                      style: GoogleFonts.inter(
//                        fontSize: 13,
//                        fontWeight: FontWeight.w600,
//                        color: Colors.white,
//                      ),
//                    ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: W / 9.6, left: W / 19.2, right: W / 19.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              controller: _displayName,
                              validator: (value) {
                                return dispNameExists;
                              },
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: white.withOpacity(0.7)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(width: 1, color: white)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(width: 1, color: textColorW),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Bid365AppTheme.Disabled),
                                ),
                                labelText: "VOLUNTEER ID",
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              controller: _phoneNumber,
                              validator: Validator.validatePhoneNumber,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              decoration: InputDecoration(
                                prefixText: '+91 ',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: white.withOpacity(0.7)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(width: 1, color: white)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(width: 1, color: textColorW),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Bid365AppTheme.Disabled),
                                ),
                                labelText: "PHONE NUMBER",
                                prefixStyle: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              controller: _email,
                              validator: Validator.validateEmail,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: white.withOpacity(0.7)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(width: 1, color: white)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(width: 1, color: textColorW),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Bid365AppTheme.Disabled),
                                ),
                                labelText: "EMAIL",
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: true,
                              controller: _password,
                              validator: Validator.validatePassword,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: white.withOpacity(0.7)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(width: 1, color: white)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(width: 1, color: textColorW),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Bid365AppTheme.Disabled),
                                ),
                                labelText: "PASSWORD",
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: _referralCode,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: white.withOpacity(0.7)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(width: 1, color: white)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(width: 1, color: textColorW),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Bid365AppTheme.Disabled),
                                ),
                                labelText: "REFERAL CODE",
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 50.0),
                          GestureDetector(
                            onTap: () async {
                              print('i was clicked');
                              Pattern pattern = '[@#^%&]';
                              RegExp regex = new RegExp(pattern);
                              String checklen = _displayName.text.toString();
                         
                              if (!(checklen.length >= 3)) {
                                setState(() {
                                  this.dispNameExists = "Enter Name of min length 3";
                                });
                              } else {
                                if (regex.hasMatch(_displayName.text))
                                  setState(() {
                                    this.dispNameExists =
                                        'Please Enter Alphanumeric Name.';
                                  });
                                else {
                                  String dispName = _displayName.text
                                      .toLowerCase()
                                      .replaceAll(new RegExp(r"\s+"), "");

                                  var UserNameData = await DbQuery.instanace
                                      .checkIfDispNameExists(dispName);
                                  setState(() {
                                    this.dispNameExists =
                                        UserNameData.docs.length > 0
                                            ? 'Name already Taken'
                                            : null;
                                  });
                                }
                              }
                              _emailSignUp(
                                  dispName: _displayName.text,
                                  email: _email.text,
                                  password: _password.text,
                                  phoneNumber: _phoneNumber.text,
                                  referralCode:
                                      _referralCode.text.toUpperCase(),
                                  context: context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Colors.greenAccent[200],
                    Colors.blueAccent[200]], tileMode: TileMode.clamp,),
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: W / 8,
                                child: Center(
                                  child: Text('CONFIRM',
                                      style: Bid365AppTheme.kInterHeading
                                          .copyWith(
                                              color: textColorB,
                                              letterSpacing: 1)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
