import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';



class Bid365AppFun {
  static Bid365AppFun get instanace => Bid365AppFun();


  setLocalMethod()async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
  var x = prefs.get('FCMToken');
  print('value os fc is ${x}');
  return x;
  }
}
class Bid365AppTheme {
  Bid365AppTheme._();


var x = Bid365AppFun.instanace.setLocalMethod();


  static const Color DemiEmphasis = Color(0xffA3BBD3);
  static const Color MediumEmphasis = Color(0xff7888A4);
  static const Color PrimaryRust = Color(0xff00CEB8);
  static const Color Disabled = Color(0xff677897);
  static const Color Grey4 = Color(0xffEFEFEF);
  static const Color Grey2 = Color(0xff2F3A4E);
  static const Color Dark2 = Color(0xff102131);
  static const Color Dark1 = Color(0xff090D1C);
  static const Color Grey1 = Colors.white;
  static const Color Grey3 = Color(0xff374253);
  static const Color Red1 = Color(0xffF15156);
  static const Color WhiteHighEmphasis = Color(0xffffffff);
  static const Color RedAccent = Colors.redAccent;
  static const Color GreenAccent = Colors.greenAccent;
  static const Color White1 = Color(0xFFe1e2e1);





  static TextStyle ksuperHeading = GoogleFonts.sourceSansPro(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.white.withOpacity(0.87));

  static TextStyle kInterHeading = GoogleFonts.sourceSansPro(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.white.withOpacity(0.87));



  static TextStyle h1B = GoogleFonts.sourceSansPro(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Colors.white.withOpacity(0.87));

  static TextStyle kInterSubheading = GoogleFonts.sourceSansPro(
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Colors.white.withOpacity(0.87));


  static TextStyle kSubheading = GoogleFonts.lato(
      fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xff677897));

  static TextStyle kHeadingFont = GoogleFonts.lato(
      fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xffa3bbd3));

  static TextStyle kCardTitle = GoogleFonts.lato(
      fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xffa3bbd3));


  static const Color darkOrange = Color(0xffFF5000);
  static const Color LightGrey1 = Color(0xff232323);
  static const Color LightGrey = Color(0xff192133);
  static const Color BackgroundNearlyBlack = Color(0xff0C0C0C);

  static const String fontNameF = 'Roboto';
  static const Color lightTextF = Color(0xFF4A6572);
  static const Color nearlyDarkBlueF = Color(0xFF2633C5);

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFFFFFF);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static const Color light_grey = Color(0xFFEFF1F4);
  static const Color p_green = Color(0xff00ff87);
  static const Color p_purple = Color(0xff37003C);
  static const Color nearlyGreen = Color(0xff00ff87);
  static const Color nearlyRed = Color(0xffe90053);
  static const Color womenBg = Color(0xffF0AEAF);

  static const Color gradient0 = Color(0xffFFB397);
  static const Color gradient1 = Color(0xffF46AA0);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF3a416f);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );


static const Color light1 = Color(0xffA3BBD3);
static const Color light2 = Color(0xffFFFFFF);
static const Color dark1 = Color(0xff090D1C);
static const Color dark2 = Color(0xff102131);

static const Color grey1 = Color(0xff262E41);
static const Color grey2 = Color(0xff2F3A4E);
static const Color grey3 = Color(0xff374253);
static const Color grey4 = Color(0xff3E4A60);
static const Color primary = Color(0xff00CEB8);
static const Color primaryDisabled = Color(0xff004E46);

static const Color white = Color(0xffFFFFFF);
static const Color demi = Color(0xffA3BBD3);
static const Color medium_demi = Color(0xff7888A4);
static const Color disabled = Color(0xff677897);
static const Color danger = Color(0xffF15156);


 static TextStyle h1Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 30,
      color: Colors.white.withOpacity(0.87));
     
  static TextStyle h2Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 23,
      color: textColorW);   
static TextStyle h3Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 18,
      color: textColorW); 
  static TextStyle h4Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 16,
      color: textColorW);  

   static TextStyle h5Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 14,
      color: textColorW);
   static TextStyle h6Slim = GoogleFonts.sourceSansPro(
      // fontWeight: FontWeight.w700,
      fontSize: 13,
      color: textColorW);          


// upcoming matches on main page
static TextStyle headingStyle = h3Slim.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.18); 

// navgivation menu bar
  static TextStyle bottomMenuStyle = GoogleFonts.sourceSansPro(
     fontSize: 12,  fontWeight: FontWeight.w500);         

  static  TextStyle  title = 
    GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 15, color: light1,letterSpacing: 0.18,);

    static  TextStyle  title1 = 
    GoogleFonts.lato(
      fontWeight: FontWeight.w500, fontSize: 11, color: light2,letterSpacing: 0.18,);

    static  TextStyle  titleBold = 
    GoogleFonts.lato(
      fontWeight: FontWeight.w500, fontSize: 13, color: light1,);

    static  TextStyle  menuText = 
        GoogleFonts.lato(fontWeight: FontWeight.w700,fontSize:15,color: Colors.white.withOpacity(0.87) );

  static  TextStyle  h1 = 
    GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 22, color: white,letterSpacing: 0.18,);
  static  TextStyle  h3 = 
   GoogleFonts.lato(
      fontWeight: FontWeight.w500, fontSize: 16, color: light1,);
    // static  TextStyle  titleBold = 
    //     GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize:13,color: Colors.white.withOpacity(0.87) ); 






  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 26,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle teamTitle = TextStyle(
    // Caption -> caption
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    letterSpacing: 0.2,
    color: nearlyBlack, // was lightText
  );
  static const TextStyle tabHeader = TextStyle(
    // Caption -> caption
    fontSize: 14.0,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold, // was lightText
  );
  static const TextStyle subTitle1 = TextStyle(
    // Caption -> caption
    fontWeight: FontWeight.w200,
    fontFamily: 'WorkSans',
    fontSize: 12,
    // letterSpacing: 0.27,
    color: grey, // was lightText
  );
  static const TextStyle subTitle2 = TextStyle(
    // Caption -> caption
    fontWeight: FontWeight.w200,
    fontFamily: 'WorkSans',
    fontSize: 14,
    // letterSpacing: 0.27,
    color: nearlyBlack, // was lightText
  );
  static const TextStyle value = TextStyle(
    // Caption -> caption
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.27,
    color: nearlyBlack, // was lightText
    fontFamily: 'WorkSans',
  );
  static const TextStyle money = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.27,
    color: nearlyBlack,
    fontFamily: 'WorkSans',
  );
}
