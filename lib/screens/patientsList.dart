import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/widgets/myHeader.dart';

import 'package:google_fonts/google_fonts.dart';

@override
Widget build(BuildContext context) {
  return Scaffold();
}

class PatientsList extends StatefulWidget {
  PatientsList({
    Key key,
  }) : super(key: key);

  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList>
    with SingleTickerProviderStateMixin {
  bool sideBarLeft;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    sideBarLeft = true;
    _tabController = new TabController(length: 3, vsync: this);
  }

  var n = 10;
  Widget RankPrice(rank, prize) {
    print(n);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 46,
            decoration: n == 10
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#Rank ${rank}",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "₹ ${prize}",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1.5,
            color: Colors.grey.withOpacity(0.3),
          )
        ],
      ),
    );
  }

  Widget LeadershipCard(PD) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage("imageUrl"),
            radius: 15,
          ),
          title: Text(
            '${PD['dispName']}',
          ),
          // title: Text('PD')
        ),
        Container(
          height: 2,
          color: Color(0xFF3E4A60),
        )
      ],
    );
  }

  Widget PrizePool() {
    return Expanded(
        flex: 5,
        child: Container(
          // decoration: new BoxDecoration(
          //   gradient: new LinearGradient(
          //       colors: [bgColor, bgColor],
          //       begin: const FractionalOffset(0.5, 0.0),
          //       end: const FractionalOffset(0.0, 0.5),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(220),
                child:    MyHeader(
              image: "assets/coronadr1.svg",
              textTop: "Patients List",
              textBottom: "",
              offset: 0,
            ),
                // backgroundColor: Color(0xff262E41),
              ),
              body: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SingleChildScrollView(
      child: Column(
        children: [
          colorCard("Rama", 5, 'Male','+','96%',"No", "25-May", context, Color(0xFF1b5bff)),
          colorCard("Sita", 5, 'Male','+','90%',"No", "23-May", context, Color(0xFF1b5bff)),
           colorCard("Lakshmana", 5,'Male','+','89%', "No", "22-May", context, Color(0xFF1b5bff)),
            colorCard("Hanuman", 1,'Male','+','80%' ,"Yes", "21-May", context, Color(0xFFff3f5e)),
        ],
      ),
    )
              ),
            ),
          ),
        ));
  }



  Widget ReceivedOrders() {
    return ListView(
      children: [
        orderCard(),
        // orderCard(),
        // orderCard(),
      ],
    );
  }

  Widget Distributed() {
    return Text("Date, order status, differentTypes of medicines count");
  }

  Widget orderCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      height: 164,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // height: 29,
                      // width: 65,
                      margin: EdgeInsets.fromLTRB(12, 14, 13, 17),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 114,
            // margin: EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //     color: Color(0xFF31394C),
            //     borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: Text(
                    "Prize Pool",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget colorCard(String text,  amount, gender,covidResult,oxoreading, otherDiseases, deliveryDate,
      BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15, right: 15),
      padding: EdgeInsets.all(15),
      height: 180,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(
                        children: <Widget>[
                          SizedBox(width: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Name: ${text}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 5.0),
                              Text('Severity: ${amount}',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white))
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                  SizedBox(height: 15.0),
               
                ],
              ),
                Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Gender: ${gender}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 5.0),
                              Text('Covid: ${covidResult}',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white))
                            ],
                          )
  
            ],
          ),


SizedBox(height: 16,),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
               Stat(otherDiseases, 'Other Diseases'),
               Stat(oxoreading, 'Oxo Reading'),
            
               
                ],
              )
        ],
      ),
    );
  }

  Widget Stat(fig, text) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),
        Text(
          '${fig}',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: false ? Color(0xFF1b5bff) : Colors.white),
        ),
        SizedBox(height: 7.0),
        Text(
          '${text}',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12.0,
              color: false ? Color(0xFF1b5bff) : Colors.white),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Material(
//    type: MaterialType.transparency
      child: Container(
        child: Column(
          children: [PrizePool()],
        ),
      ),
    );
  }
}
