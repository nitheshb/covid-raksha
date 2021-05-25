



import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/widgets/custom_appbar_widget.dart';
import 'package:flutter_covid_dashboard_ui/widgets/donutChart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicineOrderStats extends StatefulWidget {
  @override
  _MedicineOrderStatsState createState() => _MedicineOrderStatsState();
}

class _MedicineOrderStatsState extends State<MedicineOrderStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            height: 275,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 25),
            child: Image.asset("assets/images/virus2.png"),
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomAppBarWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "STATISTICS",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  _buildStatistic(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildGender(Icons.person,
                              Color(0xffFF8A5E), "MALE", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildGender(Icons.person,
                              Colors.pinkAccent, "FEM", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2),
                   Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Color(0xffFF8A5E), "18-30", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Colors.pinkAccent, "31-40", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                 Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Color(0xffFF8A5E), "41-50", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Colors.pinkAccent, "51-60", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                    Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Color(0xffFF8A5E), "61-70", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildGender(Icons.ac_unit,
                              Colors.pinkAccent, "71-100", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      height: 170,
                      child: Center(child: Image.asset("assets/images/map.png")),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGender(IconData icon, Color color, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 25,
                color: color,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Recovered\nCase",
                    style: TextStyle(
                      color: Colors.black38,
                      height: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatistic() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: DonutPieChart.withSampleData(),
            ),
            SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildStatisticItem(
                    Color(0xffA66DFF), "Applied", "23,29,539"),
                _buildStatisticItem(
                    Color(0xff4FE5B8), "Recovered", "5,92,229"),
                _buildStatisticItem(Color(0xffFF8A5E), "Deaths", "1,60,717"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(Color color, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.label,
          size: 50,
          color: color,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 5),
            Text(value),
          ],
        ),
      ],
    );
  }
}



class AppColors {
  static final Color backgroundColor = Color(0XFFefedf2);
  static final Color mainColor = Color(0XFF8d12fe);
}


/// Flutter icons FlutterIcons
/// Copyright (C) 2020 by original authors @ fluttericon.com, fontello.com
/// This font was generated by FlutterIcon.com, which is derived from Fontello.
///
/// To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  FlutterIcons
///      fonts:
///       - asset: fonts/FlutterIcons.ttf
///
/// 
/// * Material Design Icons, Copyright (C) Google, Inc
///         Author:    Google
///         License:   Apache 2.0 (https://www.apache.org/licenses/LICENSE-2.0)
///         Homepage:  https://design.google.com/icons/
///

