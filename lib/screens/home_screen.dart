import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/config/palette.dart';
import 'package:flutter_covid_dashboard_ui/config/styles.dart';
import 'package:flutter_covid_dashboard_ui/data/data.dart';
import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:flutter_covid_dashboard_ui/screens/OrderForm.dart';
import 'package:flutter_covid_dashboard_ui/screens/medicineStats.dart';
import 'package:flutter_covid_dashboard_ui/screens/myOrders.dart';
import 'package:flutter_covid_dashboard_ui/screens/orderStatsScreen.dart';
import 'package:flutter_covid_dashboard_ui/util/auth.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:flutter_covid_dashboard_ui/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _country = 'IN';
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    appState = StateWidget.of(context).state;
    var sname, dname, mname, vname, gsname, sId, dId, mId, vId, gsId;
    try {
      sname = appState?.locationName['sname'] ?? 'Pick a place';
      dname = appState?.locationName['dname'] ?? 'Pick a place';
      mname = appState?.locationName['mname'] ?? 'Pick a place';
      vname = appState?.locationName['vname'] ?? 'Pick a place';
      gsname = appState?.locationName['gsname'] ?? 'Pick a place';
      sId = appState?.locationName['sId'] ?? 'Pick a place';
      dId = appState?.locationName['dId'] ?? 'Pick a place';
      mId = appState?.locationName['mId'] ?? 'Pick a place';
      vId = appState?.locationName['vId'] ?? 'Pick a place';
      gsId = appState?.locationName['gsId'] ?? 'Pick a place';
    } catch (e) {}

    // print('value are ${dname}');
    // print('value are ${mname}');
    // print('value are ${vname}');
    // print('value are ${gsname}');
    // print('value are  1 ${sId}');
    // print('value are mm 2 ${dId}');
    // print('value are mm3 ${mId}');
    // print('value are mm4 ${vId}');
    // print('value are mm5 ${gsId}');
    //  var locationName = appState?.sname ?? 'Pick a place';

    // var x = Auth.getUserLocationLocal();
    // print('whats this ${x}');
    // locationName = x;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight, sname),
          _buildPreventionTips(screenHeight),
          _buildYourOwnTest(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight, locationName) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-RAKSHAK ${locationName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CountryDropdown(
                  countries: [
                    'IN',
                  ],
                  country: _country,
                  onChanged: (val) => setState(() => _country = val),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       'Are you feeling sick?',
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 22.0,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: screenHeight * 0.01),
            //     Text(
            //       'If you feel sick with any COVID-19 symptoms, please call or text us immediately for help',
            //       style: const TextStyle(
            //         color: Colors.white70,
            //         fontSize: 15.0,
            //       ),
            //     ),
            //     SizedBox(height: screenHeight * 0.03),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         FlatButton.icon(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 10.0,
            //             horizontal: 20.0,
            //           ),
            //           onPressed: () {},
            //           color: Colors.red,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30.0),
            //           ),
            //           icon: const Icon(
            //             Icons.phone,
            //             color: Colors.white,
            //           ),
            //           label: Text(
            //             'Call Now',
            //             style: Styles.buttonTextStyle,
            //           ),
            //           textColor: Colors.white,
            //         ),
            //         FlatButton.icon(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 10.0,
            //             horizontal: 20.0,
            //           ),
            //           onPressed: () {},
            //           color: Colors.blue,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30.0),
            //           ),
            //           icon: const Icon(
            //             Icons.chat_bubble,
            //             color: Colors.white,
            //           ),
            //           label: Text(
            //             'Send SMS',
            //             style: Styles.buttonTextStyle,
            //           ),
            //           textColor: Colors.white,
            //         ),
            //       ],
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Prevention Tips',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                  .toList(),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(children: [
                // mainCard(context),
                SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VaccineOrderForm()));
                          },
                          child:
                              regularCard('assets/upload.svg', 'Upload Data')),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyOrders()));
                        },
                        child: regularCard('assets/virus.svg', 'MyOrders'),
                      ),
                      regularCard('assets/upload.svg', 'Delivery'),
                    ]),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MedicineOrderStats()));
                          },
                          child: regularCard('assets/trend.svg', 'Stastics')),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrderStatsScreen()));
                          },
                          child: regularCard(
                              'assets/facemask.svg', 'Demand Stats')),
                      regularCard('assets/phone.svg', 'Raw Material'),
                    ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Container mainCard(context) {
    return Container(
        // padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
          ],
        ),
        child: Row(children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 140,
            child: Image.asset(
              "assets/doctor.png",
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: 150,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Symptoms \nChecker',
                  style: textStyle(24, FontWeight.w800, Colors.black)),
              SizedBox(height: 16),
              Text('Based on common \symptoms',
                  style: textStyle(16, FontWeight.w800, Colors.grey[600]))
            ]),
          ),
        ]));
  }

  SizedBox regularCard(String iconName, String cardLabel) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[100],
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.grey[300], offset: Offset.zero, blurRadius: 20)
            // ],
          ),
          child: SvgPicture.asset(
            iconName,
            width: 50,
            color: Palette.primaryColor,
          ),
        ),
        SizedBox(height: 5),
        Text(cardLabel,
            textAlign: TextAlign.center,
            style: textStyle(16, FontWeight.w500, Colors.black))
      ]),
    );
  }

  TextStyle textStyle(double size, FontWeight fontWeight, Color colorName) =>
      TextStyle(
        color: colorName,
        fontSize: size,
        fontWeight: fontWeight,
      );
  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          color: Color(0xFFAD9FE4),
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/images/own_test.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Do your own test!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Follow the instructions\nto do your own test.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
