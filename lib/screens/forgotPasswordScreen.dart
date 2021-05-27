
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_dashboard_ui/screens/signIn.dart';
import 'package:flutter_covid_dashboard_ui/themeFile.dart';
import 'package:flutter_covid_dashboard_ui/util/auth.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:flutter_covid_dashboard_ui/util/formValidator.dart';
import 'package:flutter_covid_dashboard_ui/util/loadingScreen.dart';
import 'package:get/get.dart';


class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
                               style: TextStyle(color: Colors.white, fontSize: 16.0),
                      decoration: InputDecoration(
                         prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ),
                     enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(width: 1,color: textColorW),
                                ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 1,)
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 1,color: white)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 1,color: textColorW)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1,color:textColorW),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1,color: Bid365AppTheme.Disabled),
                      ),
                      labelText: "Email",
                      labelStyle: Bid365AppTheme.kCardTitle,
                    )
    
    );

    final forgotPasswordButton = Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primary,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 48.0,
                                child: Center(
                                  child: Text('RESET PASSWORD',
                                    style: Bid365AppTheme.kInterHeading.copyWith(color: textColorB, letterSpacing: 1)
                                  ),
                                ),
                              ),
                            );

    final signInLabel = FlatButton(
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
            Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage(
                                                              ),
                                                      ));

      },
    );

    return Scaffold(
       backgroundColor:bgColor,
       resizeToAvoidBottomInset: true,
      body: LoadingScreen(
          child: Container(
            child: Column(
              children: [
                  Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20,
                      top: 60
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(width: 100,),
                          InkWell(
                            onTap: (){
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
                            },
                            child: Text('RDX Gamers',
                              style: Bid365AppTheme.kInterHeading.copyWith(color: bgBlackShade),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.0),
                      Text('Reset Password',
                        style: Bid365AppTheme.kInterHeading.copyWith(color: textColorB,fontSize: 34),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // logo,
                            SizedBox(height: 48.0),
                            email,
                            SizedBox(height: 16.0),
                            InkWell(onTap: (){
                              _forgotPassword(_email.text, context);
                            },child: forgotPasswordButton),
                            signInLabel
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _forgotPassword(String email, BuildContext context) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        await Auth.forgotPasswordEmail(email);
        await _changeLoadingVisible();
        //   Fluttertoast.showToast(
        // msg: 'Check your email and follow the instructions to reset your password.'
        //   );
              Get.snackbar(
  "SUCCESS:  'Check your email and follow the instructions to reset your password.'", // title
  "", // message
  icon: Icon(Icons.check), 
  shouldIconPulse: true,
  barBlur: 20,
  isDismissible: true,
  duration: Duration(seconds: 15),
);
        // Flushbar(
        //   title: "Password Reset Email Sent",
        //   message:
        //       'Check your email and follow the instructions to reset your password.',
        //   duration: Duration(seconds: 20),
        // )..show(context);
      } catch (e) {
        _changeLoadingVisible();
        print("Forgot Password Error: $e");
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
        //   Fluttertoast.showToast(
        // msg: "Forgot Password Error ${exception}");
      
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
