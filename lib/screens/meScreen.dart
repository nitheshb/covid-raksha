import 'package:flutter/material.dart';
// import 'package:locApp/bid365_app_theme.dart';
// import 'package:locApp/lib_new/screens/compliantScreen.dart';
// import 'package:locApp/lib_new/screens/fantasyPointSystem.dart';
// import 'package:locApp/lib_new/screens/loginPage.dart';
// import 'package:locApp/lib_new/screens/refer&earn.dart';
// import 'package:locApp/lib_new/screens/splashScreen.dart';
// import 'package:locApp/lib_new/screens/termaOfService.dart';
// import 'package:locApp/lib_new/screens/verification_page.dart';
// import 'package:locApp/lib_new/screens/verifyPan.dart';
// import 'package:locApp/lib_new/screens/walletScreen.dart';
// import 'package:locApp/lib_new/theme/colors.dart';
// import 'package:locApp/models/state.dart';

// import 'package:locApp/util/state_widget.dart';

import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:flutter_covid_dashboard_ui/screens/locationSel.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_covid_dashboard_ui/themeFile.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_covid_dashboard_ui/screens/splashScreen.dart';

class MeScreen1 extends StatefulWidget {
  @override
  _MeScreen1State createState() => _MeScreen1State();
}

class _MeScreen1State extends State<MeScreen1> {
  StateModel appState;
  bool sideBarLeft;
  String locationText, hoText, soText, stText;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    sideBarLeft = true;
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget build(BuildContext context) {
    var email;
    try {
      appState = StateWidget.of(context).state;
      email = appState?.firebaseUserAuth?.email ?? '';
      appState = StateWidget.of(context).state;
      var y = appState?.user;

      print('value of ${y?.dispName}');
      // print('appState. ${appState.locationName}');
      final locationName = appState?.locationName ?? 'Pick a place';
      final hoName = appState?.hoName ?? '';
      final soName = appState?.soName ?? '';
      final stName = appState?.stName ?? '';

      setState(() {
        locationText =
            locationName == '' ? 'Select ur preferred Location' : locationName;
        hoText = hoName == '' ? '' : hoName;
        soText = soName == '' ? '' : soName;
        stText = stName == '' ? '' : stName;
      });
    } catch (e) {}

    return Material(
      color: Color(0xff090D1C),
      child: Row(
        children: [
          contentWidget(email),
        ],
      ),
    );
  }

  Widget contentWidget(email) {
    bool isSwitched = false;
    return Flexible(
      // flex: 5,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: grey,
          title: InkWell(
            onTap: () {
              //          Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
              // builder: (BuildContext context)
              // => BottomNavBar1(),
              // ),(Route<dynamic> route) => false);
            },
            child: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Row(
                children: [
                  Text(
                    '${locationText}',
                    style: Bid365AppTheme.kInterHeading
                        .copyWith(color: textColorW),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(3.0),
                  //   child: Image.asset(
                  //     'assets/downarrow.png', height: 5, width: 8,color: textColorW),
                  // ),
                ],
              ),
            ),
          ),
          leading: Image.asset(
            'assets/IndianFlag.png',
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, bottom: 0, left: 8, right: 8),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgBlackShade,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPan()),);
                    // },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/playerimg.png',
                            height: 72,
                            width: 72,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 27.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${email}',
                                style: Bid365AppTheme.kInterHeading.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: textColorW),
                              ),
                              Text('${locationText},${soText}',
                                  style: Bid365AppTheme.kInterHeading.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: textColorW)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    cont1(),
                    cont2(),
                    cont3(),
                    cont4(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget cont1() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 0, left: 8, right: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: grey,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetLocation()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, right: 14, left: 16, bottom: 14),
                    child: Text(
                      'My Region',
                      style: Bid365AppTheme.kInterSubheading
                          .copyWith(color: textColorW),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => VerificationPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 16, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'KYC',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cont2() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 0, left: 8, right: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: grey,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ReferEarn()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'Refer and Earn',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cont3() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 0, left: 8, right: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: grey,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => FantasyPoints()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 16, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'Fantasy Points System',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserCompliantScreen()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 16, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'Customer Care',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cont4() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 8, right: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: grey,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TermsOfServicePage()),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'Terms & Conditions',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textColorW,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 14, left: 16, bottom: 14),
                      child: Text(
                        'Version',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_packageInfo.version,
                        style: Bid365AppTheme.h4Slim),
                  )
                ],
              ),
            ),
            Visibility(
              child: InkWell(
                onTap: () async {
                  print('logout is clicked');
                  StateWidget.of(context).logOutUser();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: 14, left: 16, bottom: 17),
                      child: Text(
                        'Logout',
                        style: Bid365AppTheme.kInterSubheading
                            .copyWith(color: textColorW),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
