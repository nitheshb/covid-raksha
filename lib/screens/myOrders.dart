import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:flutter_covid_dashboard_ui/screens/HowToUseVideo.dart';
import 'package:flutter_covid_dashboard_ui/screens/patientsList.dart';
import 'package:flutter_covid_dashboard_ui/util/firebaseQueries.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:flutter_covid_dashboard_ui/widgets/myHeader.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

@override
Widget build(BuildContext context) {
  return Scaffold();
}

class MyOrders extends StatefulWidget {
  MyOrders({
    Key key,
  }) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  bool sideBarLeft;
  TabController _tabController;
  String _priority = "Recovered";
  String title;
  String description;
  StateModel appState;

  final _priorities = [
    "Recovered",
    "Recovered Partially",
    "Showed SideEffects",
    "Death",
  ];
  final schemes_list = [
    "Pension",
    "YSR Rythu Bharosa",
    "Fee reimbursement",
    "Aarogyasri",
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController category = new TextEditingController();
  final TextEditingController subject = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  @override
  void initState() {
    super.initState();
    sideBarLeft = true;
    _tabController = new TabController(length: 4, vsync: this);
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

  Widget PrizePool(uId) {
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
                child: MyHeader(
                  image: "assets/coronadr.svg",
                  textTop: "Get to know",
                  textBottom: "About Covid-19.",
                  offset: 0,
                ),
                // backgroundColor: Color(0xff262E41),
              ),
              body: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: Colors.black.withOpacity(0.7),
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: 'ORDERS',
                        ),
                        Tab(
                          text: 'MED COLLECTED',
                        ),
                        Tab(
                          text: 'DISTRIBUTED',
                        ),
                        Tab(
                          text: 'FEEDBACK',
                        ),
                      ],
                      labelStyle: GoogleFonts.lato(
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.black.withOpacity(0.5),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          LiveOrders(uId),
                          ReceivedOrders(),
                          Distributed(),
                          feedbackForm(),
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget LiveOrders(uId) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
              stream: DbQuery.instanace.SteamData(uId),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: '));
                else if (snapshot.hasData) {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildGender(Icons.person, Colors.pinkAccent, "Total", "40.5%"),
                );
                  return colorCard(
                      "8", 0, "20-May", "21-May", context, Color(0xFF1b5bff));
                }
                return Container();
              }),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildSmallCard(Icons.person,
                              Color(0xffFF8A5E), "P", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildSmallCard(Icons.person,
                              Colors.pinkAccent, "L", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildSmallCard(Icons.person,
                              Color(0xffFF8A5E), "F", "59.5%"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildSmallCard(Icons.person,
                              Colors.pinkAccent, "N", "40.5%"),
                        ),
                      ],
                    ),
                  ),
                     Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
            
                        Expanded(
                          child: _buildSmallCard(Icons.person,
                              Colors.pinkAccent, "D", "40.5%"),
                        ),
                      ],
                    ),
                  ),
          colorCard("18", 0, "23-May", "25-May", context, Color(0xFF1b5bff)),
          colorCard("12", 0, "22-May", "23-May", context, Color(0xFF1b5bff)),
          colorCard("5", 0, "21-May", "22-May", context, Color(0xFF1b5bff)),
          colorCard("8", 0, "20-May", "21-May", context, Color(0xFF1b5bff)),
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
                  // Text(
                  //   "Recovered\nCase",
                  //   style: TextStyle(
                  //     color: Colors.black38,
                  //     height: 1.5,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
         
             Column(
               children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Stat(7, 'ORDERS'),
                    SizedBox(width: 6.0),
                    Stat(2, 'COLLECTED'),
                    SizedBox(width: 6.0),
                    Stat(2, 'DELIVERED'),
                    // SizedBox(width: 6.0),
                    // Stat(7, '')
                  ],
            ),
            Divider(),
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Stat(7, 'CRITICAL'),
                    SizedBox(width: 10.0),
                    Stat(2, 'FEEDBACK'),
                    SizedBox(width: 10.0),
                    Stat(2, 'PENDING  '),
                    // SizedBox(width: 6.0),
                    // Stat(7, '')
                  ],
            ),
               ],
             )
        ],
      ),
    );
  }
  Widget _buildSmallCard(IconData icon, Color color, String title, String value) {
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
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Icon(
                //   icon,
                //   size: 25,
                //   color: color,
                // ),
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
                      "Medicine",
                      style: TextStyle(
                        color: Colors.black38,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                  Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
              ],
            ),
            SizedBox(
              height: 20,
            ),
               //my color line
         

              InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoApp()));
                            },
                            child: Container(
                                height: 32,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //border: Border.all(width:1, color:Colors.white24),
                                  gradient: LinearGradient(colors: [Colors.greenAccent[200],
                    Colors.blueAccent[200]], tileMode: TileMode.clamp,)
                                ),
                                child: Center(
                                  child: Text('How to use?'.toUpperCase(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13,
                                          color: Colors.black,
                                          letterSpacing: 1)),
                                )),
                          ),
  
           
          ],
        ),
      ),
    );
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
                    "Received Medicine Details",
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

  TextStyle textStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black54,
    fontWeight: FontWeight.w600,
  );
  Widget feedbackForm() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              blurRadius: 15.0,
              spreadRadius: -5.0,
              offset: Offset(0.0, 7.0)),
        ],
      ),
      width: 320.0,
      height: 420.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Patient Feedback Form',
                    contentPadding: EdgeInsets.zero,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _priority,
                      onChanged: (newValue) => {setState(() {})},
                      items: _priorities.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              TextField(
                  maxLength: 30,
                  onChanged: (value) {
                    print('-->%%%%%%%%%%%%%%%%%%%%%%%123');
                  },
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  style: textStyle,
                  decoration: InputDecoration(
                    hintText: 'No of does Taken',
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    labelStyle: textStyle,
                  )),
              TextFormField(
                  maxLength: 50,
                  onEditingComplete: () {
                    print('-->%%%%%%%%%%%%%%%%%%%%%%%');
                  },
                  onSaved: (value) => {
                        setState(() {
                          //  issueData.subject = value;
                          // _priority = value;
                        })
                      },
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'age cannot be left empty';
                  //   }

                  //   if (value.length > 30) {
                  //     return 'age should be greater than 60';
                  //   }
                  // },
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  style: textStyle,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    labelStyle: textStyle,
                  )),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.all(13.0),
                elevation: 2.0,
                textColor: Colors.white,
                color: Colors.amber,
                //  onPressed: () => Save(),
                //  onPressed: () => _showBottomSheet(),
                onPressed: () {},
                //                     onPressed: () => {
                //                         addData2Fire("vol_tickets", issueData).then((onValue){
                //   print("check for inserted uid $onValue");
                // })
                // },
                // onPressed: () => {},
                child: Text(
                  "Feedback",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorCard(String text, double amount, todayDate, deliveryDate,
      BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PatientsList()));
      },
      child: Container(
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
                                Text('Total Orders: ${text}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    )),
                                SizedBox(height: 5.0),
                                Text('Pending: ${amount}',
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
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Order Date: ',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10.0,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${todayDate}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: <Widget>[
                        Text(
                          '    Delivery: ',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10.0,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${deliveryDate}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Stat(7, 'L'),
                SizedBox(width: 6.0),
                Stat(2, 'K'),
                SizedBox(width: 6.0),
                Stat(2, 'F'),
                SizedBox(width: 6.0),
                Stat(7, 'D')
              ],
            )
          ],
        ),
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
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: true ? Color(0xFF1b5bff) : Colors.white),
        ),
        SizedBox(height: 7.0),
        Text(
          '${text}',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14.0,
              color: true ? Colors.black38 : Colors.white),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }

  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    var uId, sname, dname, mname, vname, gsname, sId, dId, mId, vId, gsId;
    try {
      uId = appState?.firebaseUserAuth?.uid ?? '';
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
    return Material(
//    type: MaterialType.transparency
      child: Container(
        child: Column(
          children: [PrizePool(uId)],
        ),
      ),
    );
  }
}
