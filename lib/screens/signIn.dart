import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_dashboard_ui/screens/forgotPasswordScreen.dart';
import 'package:flutter_covid_dashboard_ui/screens/screens.dart';
import 'package:flutter_covid_dashboard_ui/screens/signUp.dart';
import 'package:flutter_covid_dashboard_ui/themeFile.dart';
import 'package:flutter_covid_dashboard_ui/util/auth.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:flutter_covid_dashboard_ui/util/formValidator.dart';
import 'package:flutter_covid_dashboard_ui/util/loadingScreen.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  FocusNode _focusNode, _focusNodePassword;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  var W; 

  @override
  void initState() {
    super.initState();
    // _focusNode = FocusNode();
    // _focusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    // _focusNodePassword.dispose();
    super.dispose();
  }

//  _requestFocus(_focusNode){
//   setState(() {
//     FocusScope.of(context).requestFocus(_focusNode);
//   });
// }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await StateWidget.of(context).logInUser(email, password);
        print('successfully validated');

        await Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (BuildContext context) => BottomNavScreen(),
            ),
            (Route<dynamic> route) => false);
      } catch (e) {
        _changeLoadingVisible();
        print("Sign In Error: $e");
        String exception = Auth.getExceptionText(e);
        Get.snackbar(
          "ERROR:  ${exception}", // title
          "", // message
          icon: Icon(Icons.error),
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          duration: Duration(seconds: 8),
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
                  // height: MediaQuery.of(context).size.height * 0.25,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.greenAccent[200],
                    Colors.blueAccent[200]], tileMode: TileMode.clamp,),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(left: W/19.2, top: W/12.8, bottom: W/9.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(
                              width: W/3.45,
                              height: W/3.45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/icon/rdx.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: W/19.2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'LOGIN',
                              style: Bid365AppTheme.ksuperHeading
                                  .copyWith(color: textColorB, fontSize: 30),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(horizontal: W/19.2),
                                child: Text(
                                  'SIGNUP',
                                  style: Bid365AppTheme.h1B.copyWith(
                                    color: textColorB,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      padding:  EdgeInsets.only(
                          top: W/9.6, left: W/19.2, right: W/19.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                        Text('Email',
//                          style: GoogleFonts.inter(
//                              fontSize: 16,
//                              fontWeight: FontWeight.w700,
//                              color: Colors.white
//                          ),
//                        ),
                          SizedBox(height: W/38.4),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 15.0),
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
                                labelText: "Email".toUpperCase(),
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
                              focusNode: _focusNodePassword,
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
                                labelText: "Password".toUpperCase(),
                                labelStyle: Bid365AppTheme.kCardTitle.copyWith(
                                    color: white.withOpacity(.9),
                                    letterSpacing: 1.2,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment(0.0, 0.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                              },
                              child: Text('Forgot Password?'.toUpperCase(),
                                  style: Bid365AppTheme.kCardTitle.copyWith(
                                      color: white.withOpacity(.7),
                                      letterSpacing: 1.2,
                                      fontSize: 11)),
                            ),
                          ),
                          SizedBox(height: 60.0),
                          GestureDetector(
                            onTap: () {
                              _emailLogin(
                                  email: _email.text,
                                  password: _password.text,
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
                                height: W/8,
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
