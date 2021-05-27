import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/models/state.dart';
import 'package:flutter_covid_dashboard_ui/screens/screens.dart';
import 'package:flutter_covid_dashboard_ui/themeFile.dart';
import 'package:flutter_covid_dashboard_ui/util/colors.dart';
import 'package:flutter_covid_dashboard_ui/util/firebaseQueries.dart';
import 'package:flutter_covid_dashboard_ui/util/formValidator.dart';
import 'package:flutter_covid_dashboard_ui/util/statefulWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocation extends StatefulWidget {
  SetLocation({
    Key key,
    this.userInfo,
  }) : super(key: key);
  var userInfo;
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  StateModel appState;
  FocusNode myFocusNode = new FocusNode();
  final style1 = GoogleFonts.lato(
      fontWeight: FontWeight.w700, fontSize: 34, color: primary);
  final style5 = GoogleFonts.muli(
      fontWeight: FontWeight.w700, fontSize: 34, color: textColorB);
  final style2 = GoogleFonts.lato(
      fontWeight: FontWeight.w400, fontSize: 13, color: textColorW);
  final style3 = GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: Bid365AppTheme.PrimaryRust,
      letterSpacing: 1);
  final style4 =
      GoogleFonts.lato(fontWeight: FontWeight.w400, fontSize: 15, color: black);

  bool loading = true;
  bool showLocality = false;
  String selLocValue = "";
  var selDistrictName = {"hoName": ""};
  var selMandalName = {"soName": ""};
  var selVillageName = {"boName": ""};
  var selSachivalayam = {"sacName": ""};
  var stateId = {'sName': 'Andhra Pradesh', 'sId': "51"};

  String selDistrictId = "";
  String selMandalId = "";
  String selVillageId = "";

  String selStateValue = 'Select Your Region';
  String cityImg = "k.png";
  String cityText = "Can you win in Local Contests";

  var stateDataArray = [];

  var locDataArray = [];

  var showSelDistricts = [];
  var showSelMandals = [];
  var showSelVillages = [];
  var showGramaSac = [];

  void imageSet(img, txt) {
    setState(() {
      cityImg = img;
      cityText = 'Great Choice';
    });
  }

  void getCityImage(selState) async {
    switch (selState) {
      case 'Delhi':
        imageSet('k.png', 'Zone of Leaders');
        break;
      case 'Goa':
        imageSet('k2.png', 'City of Joy');
        break;
      case 'Gujarat':
        imageSet('m1.png', 'Zone of Stragety');
        break;
      case 'Karnataka':
        imageSet('r.png', 'Zone of Dreams');
        break;
      case 'Kerala':
        imageSet('r2.png', 'Zone of Rebels');
        break;
      case 'Maharashtra':
        imageSet('m1.png', 'Zone of Dreams');
        break;
      case 'Rajasthan':
        imageSet('r2.png', 'Zone of Dreams');
        break;
      case 'West Bengal':
        imageSet('k2.png', 'Zone of Dreams');
        break;
      default:
        imageSet('r2.png', 'Zone of Dreams');
    }
  }

  var stateObjFull = [
    {
      "statid": "51",
      "hoid": "524",
      "statName": "Andhra Pradesh",
    },
    {
      "statid": "52",
      "hoid": "517",
      "hoName": "Telangana",
    }
  ];
  var hoObjFull = [
    {
      "statid": "51",
      "hoid": "524",
      "hoName": "Nellore",
    },
    {
      "statid": "51",
      "hoid": "517",
      "hoName": "Chittor",
    }
  ];

  var soObjFull = [
    {
      "hoid": "524",
      "soid": "524321",
      "soName": "Survepalli",
    },
    {
      "hoid": "517",
      "soid": "524322",
      "soName": "Atmakur",
    }
  ];

  var boObjFull = [
    {
      "soid": "524321",
      "boid": "202",
      "boName": "Akkampeta",
    },
    {
      "soid": "524321",
      "boid": "25",
      "boName": "Althurthi",
    },
  ];

  var sacObjFull = [
    {
      "boid": "202",
      "sacid": "1",
      "sacName": "Sector-1, Schivalayam",
    },
    {
      "boid": "202",
      "sacid": "4",
      "sacName": "Sector-4, Schivalayam",
    },
    {
      "boid": "202",
      "sacid": "22",
      "sacName": "Sector-22, Schivalayam",
    },
    {
      "boid": "25",
      "sacid": "202",
      "sacName": "Sector-ysr, Schivalayam",
    },
    {
      "boid": "25",
      "sacid": "x1",
      "sacName": "Sector-x1, Schivalayam",
    },
  ];

  void getUsers(selState) async {
    print('selected state is ${selState}');
    var loc;
    if (selState != 'Select a Region') {
      loc = 'Check';
      showLocality = true;
    }

    var dataLocArrayFull = [
      {
        "stId": "52",
        "stName": "Andhra Pradesh",
        "hoObj": [
          {
            "hoid": "524",
            "hoName": "Nellore",
          },
          {
            "hoid": "517",
            "hoName": "Chittor",
          }
        ],
        "hoid": "524",
        "hoName": "Nellore",
        "soid": "524321",
        "soName": "Survepalli",
        "id": "524321",
        "name": "Nellore"
      },
    ];

    var dataArrayLocfull = [
      {
        "stId": "744",
        "stName": "Andaman and Nicobar Islands",
        "hoid": "744101",
        "hoName": "Port Blair",
        "id": "744101",
        "name": "Port Blair",
        "category": "B.O"
      },
      {
        "id": "524322",
        "name": "Atmakur1",
        "category": "B.O",
        "soId": "524322",
        "soName": "Atmakur1 ",
        "hoId": "524",
        "hoName": "Nellore ",
        "stId": "51",
        "stName": "ANDHRA PRADESH"
      },
      {
        "stId": "52",
        "stName": "Andhra Pradesh",
        "hoid": "524",
        "hoName": "Nellore",
        "soid": "524321",
        "soName": "Survepalli",
        "id": "524321",
        "name": "Nellore"
      },
      {
        "stId": "52",
        "stName": "Andhra Pradesh",
        "hoid": "530009",
        "hoName": "Visakhapatnam",
        "id": "530009",
        "name": "Visakhapatnam"
      },
      {
        "stId": "51",
        "stName": "Andhra Pradesh",
        "hoid": "530009",
        "hoName": "Visakhapatnam",
        "id": "530009",
        "name": "Visakhapatnam"
      },
      {
        "stId": "51",
        "stName": "Andhra Pradesh",
        "hoid": "520001",
        "hoName": "Vijayawada",
        "id": "520001",
        "name": "Vijayawada"
      },
      {
        "stId": "79",
        "stName": "Arunachal Pradesh",
        "hoid": "791111",
        "hoName": "Itanagar",
        "id": "791111",
        "name": "Itanagar"
      },
      {
        "stId": "79",
        "stName": "Arunachal Pradesh",
        "hoid": "792103",
        "hoName": "Namsai",
        "id": "792103",
        "name": "Namsai"
      },
      {
        "stId": "78",
        "stName": "Assam",
        "hoid": "781005",
        "hoName": "Dispur",
        "id": "781005",
        "name": "Dispur"
      },
      {
        "stId": "78",
        "stName": "Assam",
        "hoid": "783301",
        "hoName": "Dhubri",
        "id": "783301",
        "name": "Dhubri"
      },
      {
        "stId": "81",
        "stName": "Bihar",
        "hoid": "800001",
        "hoName": "Patna",
        "id": "800001",
        "name": "Patna"
      },
      {
        "stId": "81",
        "stName": "Bihar",
        "hoid": "804403",
        "hoName": "Gaya",
        "id": "804403",
        "name": "Gaya"
      },
      {
        "stId": "160",
        "stName": "Chhattisgarh",
        "hoid": "492001",
        "hoName": "Raipur",
        "id": "492001",
        "name": "Raipur"
      },
      {
        "stId": "160",
        "stName": "Chhattisgarh",
        "hoid": "493441",
        "hoName": "Bhilai",
        "id": "493441",
        "name": "Bhilai"
      },
      {
        "stId": "396",
        "stName": "Dadra and Nagar Haveli and Daman & Diu",
        "hoid": "396210",
        "hoName": "Daman",
        "id": "396210",
        "name": "Daman"
      },
      {
        "stId": "403",
        "stName": "Goa",
        "hoid": "403001",
        "hoName": "Panaji",
        "id": "403001",
        "name": "Panaji"
      },
      {
        "stId": "403",
        "stName": "Goa",
        "hoid": "403802",
        "hoName": "Vasco da Gama",
        "id": "403802",
        "name": "Vasco da Gama"
      },
      {
        "stId": "37",
        "stName": "Gujarat",
        "hoid": "382010",
        "hoName": "Gandhinagar",
        "id": "382010",
        "name": "Gandhinagar"
      },
      {
        "stId": "37",
        "stName": "Gujarat",
        "hoid": "380001",
        "hoName": "Ahmedabad",
        "id": "380001",
        "name": "Ahmedabad"
      },
      {
        "stId": "13",
        "stName": "Haryana",
        "hoid": "122001",
        "hoName": "Gurugram",
        "id": "122001",
        "name": "Gurugram"
      },
      {
        "stId": "13",
        "stName": "Haryana",
        "hoid": "121001",
        "hoName": "Faridabad",
        "id": "121001",
        "name": "Faridabad"
      },
      {
        "stId": "17",
        "stName": "Himachal Pradesh",
        "hoid": "171001",
        "hoName": "Shimla",
        "id": "171001",
        "name": "Shimla"
      },
      {
        "stId": "17",
        "stName": "Himachal Pradesh",
        "hoid": "176215",
        "hoName": "Dharamshala",
        "id": "176215",
        "name": "Dharamshala"
      },
      {
        "stId": "19",
        "stName": "Jammu & Kashmir",
        "hoid": "190001",
        "hoName": "Srinagar",
        "id": "190001",
        "name": "Srinagar"
      },
      {
        "stId": "81",
        "stName": "Jharkhand",
        "hoid": "834001",
        "hoName": "Ranchi",
        "id": "834001",
        "name": "Ranchi"
      },
      {
        "stId": "81",
        "stName": "Jharkhand",
        "hoid": "826001",
        "hoName": "Dhanbad",
        "id": "826001",
        "name": "Dhanbad"
      },
      {
        "stId": "57",
        "stName": "Karnataka",
        "hoid": "560002",
        "hoName": "Bangalore",
        "id": "560002",
        "name": "Bangalore"
      },
      {
        "stId": "57",
        "stName": "Karnataka",
        "hoid": "573201",
        "hoName": "Hassan",
        "id": "573201",
        "name": "Hassan"
      },
      {
        "stId": "68",
        "stName": "Kerala",
        "hoid": "695001",
        "hoName": "Thiruvananthapuram",
        "id": "695001",
        "name": "Thiruvananthapuram"
      },
      {
        "stId": "68",
        "stName": "Kerala",
        "hoid": "682001",
        "hoName": "Kochi",
        "id": "682001",
        "name": "Kochi"
      },
      {
        "stId": "682",
        "stName": "Ladakh",
        "hoid": "194101",
        "hoName": "Leh",
        "id": "194101",
        "name": "Leh"
      },
      {
        "stId": "682",
        "stName": "Lakshadweep",
        "hoid": "682555",
        "hoName": "Kavaratti",
        "id": "682555",
        "name": "Kavaratti"
      },
      {
        "stId": "46",
        "stName": "Madhya Pradesh",
        "hoid": "462001",
        "hoName": "Bhopal",
        "id": "462001",
        "name": "Bhopal"
      },
      {
        "stId": "46",
        "stName": "Madhya Pradesh",
        "hoid": "452001",
        "hoName": "Indore",
        "id": "452001",
        "name": "Indore"
      },
      {
        "stId": "41",
        "stName": "Maharashtra",
        "hoid": "400001",
        "hoName": "Mumbai",
        "id": "400001",
        "name": "Mumbai"
      },
      {
        "stId": "41",
        "stName": "Maharashtra",
        "hoid": "411001",
        "hoName": "Pune",
        "id": "411001",
        "name": "Pune"
      },
      {
        "stId": "79",
        "stName": "Manipur",
        "hoid": "795001",
        "hoName": "Imphal",
        "id": "795001",
        "name": "Imphal"
      },
      {
        "stId": "79",
        "stName": "Manipur",
        "hoid": "795141",
        "hoName": "Tamenglong",
        "id": "795141",
        "name": "Tamenglong"
      },
      {
        "stId": "79",
        "stName": "Meghalaya",
        "hoid": "793001",
        "hoName": "Shillong",
        "id": "793001",
        "name": "Shillong"
      },
      {
        "stId": "79",
        "stName": "Meghalaya",
        "hoid": "793108",
        "hoName": "Cherrapunji",
        "id": "793108",
        "name": "Cherrapunji"
      },
      {
        "stId": "79",
        "stName": "Mizoram",
        "hoid": "796001",
        "hoName": "Aizawl",
        "id": "796001",
        "name": "Aizawl"
      },
      {
        "stId": "79",
        "stName": "Mizoram",
        "hoid": "796181",
        "hoName": "Serchhip",
        "id": "796181",
        "name": "Serchhip"
      },
      {
        "stId": "79",
        "stName": "Nagaland",
        "hoid": "797001",
        "hoName": "Kohima",
        "id": "797001",
        "name": "Kohima"
      },
      {
        "stId": "79",
        "stName": "Nagaland",
        "hoid": "798617",
        "hoName": "Mokokchung",
        "id": "798617",
        "name": "Mokokchung"
      },
      {
        "stId": "76",
        "stName": "Odisha",
        "hoid": "751001",
        "hoName": "Bhubaneshwar",
        "id": "751001",
        "name": "Bhubaneshwar"
      },
      {
        "stId": "76",
        "stName": "Odisha",
        "hoid": "756100",
        "hoName": "Bhadrak",
        "id": "756100",
        "name": "Bhadrak"
      },
      {
        "stId": "609",
        "stName": "Puducherry",
        "hoid": "605001",
        "hoName": "Puducherry",
        "id": "605001",
        "name": "Puducherry"
      },
      {
        "stId": "17",
        "stName": "Punjab",
        "hoid": "160020",
        "hoName": "Chandigarh",
        "id": "160020",
        "name": "Chandigarh"
      },
      {
        "stId": "17",
        "stName": "Punjab",
        "hoid": "143001",
        "hoName": "Amritsar",
        "id": "143001",
        "name": "Amritsar"
      },
      {
        "stId": "31",
        "stName": "Rajasthan",
        "hoid": "302001",
        "hoName": "Jaipur",
        "id": "302001",
        "name": "Jaipur"
      },
      {
        "stId": "31",
        "stName": "Rajasthan",
        "hoid": "342001",
        "hoName": "Jodhpur",
        "id": "342001",
        "name": "Jodhpur"
      },
      {
        "stId": "737",
        "stName": "Sikkim",
        "hoid": "737101",
        "hoName": "Gangtok",
        "id": "737101",
        "name": "Gangtok"
      },
      {
        "stId": "737",
        "stName": "Sikkim",
        "hoid": "734301",
        "hoName": "Kalimpong",
        "id": "734301",
        "name": "Kalimpong"
      },
      {
        "stId": "11",
        "stName": "Delhi",
        "hoid": "110001",
        "hoName": "Delhi",
        "id": "110001",
        "name": "Delhi"
      },
      {
        "stId": "79",
        "stName": "Tripura",
        "hoid": "799001",
        "hoName": "Agartala",
        "id": "799001",
        "name": "Agartala"
      },
      {
        "stId": "79",
        "stName": "Tripura",
        "hoid": "799250",
        "hoName": "Dharmanagar",
        "id": "799250",
        "name": "Dharmanagar"
      },
      {
        "stId": "21",
        "stName": "Uttar Pradesh",
        "hoid": "226001",
        "hoName": "Lucknow",
        "id": "226001",
        "name": "Lucknow"
      },
      {
        "stId": "21",
        "stName": "Uttar Pradesh",
        "hoid": "282001",
        "hoName": "Agra",
        "id": "282001",
        "name": "Agra"
      },
      {
        "stId": "25",
        "stName": "Uttarakhand",
        "hoid": "248001",
        "hoName": "Dehradun",
        "id": "248001",
        "name": "Dehradun"
      },
      {
        "stId": "25",
        "stName": "Uttarakhand",
        "hoid": "249407",
        "hoName": "Haridwar",
        "id": "249407",
        "name": "Haridwar"
      },
      {
        "stId": "71",
        "stName": "West Bengal",
        "hoid": "700007",
        "hoName": "Kolkata",
        "id": "700007",
        "name": "Kolkata"
      },
      {
        "stId": "71",
        "stName": "West Bengal",
        "hoid": "711101",
        "hoName": "Howrah",
        "id": "711101",
        "name": "Howrah"
      }
    ];

    try {
      //  var url = "https://rdx-loc-api.azurewebsites.net/api/locationPicker?code=I5I0eCutdqNelTNNp2PbeEcpwXyEr7ZfUEUJRU3dYxxx/STQQsFoXg==&pickState=$loc";
      // final response =
      // await http.post (url,body:{"pickState": selState});
      //     // await http.post("https://us-central1-teamplayers-f3b25.cloudfunctions.net/citiesList",body:{"state": selState});
      // if (response.statusCode == 200) {
      //   print('data value1  ${response.body}');

      //   users = loadUsers(response.body, selState);
      //   print('Users: ${users}${users.length}');
      //   setState(() {
      //     loading = false;
      //      locDataArray  = json.decode(response.body).cast<Map<String, dynamic>>().where((doc) => doc["stName"] == selState).toList();
      //      selLocValue = locDataArray[0]['name'];
      //   });
      // } else {

      //   print("Error getting users1.");
      // }
      setState(() {
        loading = false;
        showSelDistricts =
            hoObjFull.where((doc) => doc["statid"] == "51").toList();
        print('selDistricts ${showSelDistricts}');
        locDataArray =
            dataArrayLocfull.where((doc) => doc["stName"] == selState).toList();
        //  selLocValue = locDataArray[0]['name'];
      });
    } catch (e) {
      print("Error getting users2. ${e}");
    }
  }

  @override
  void initState() {
    // getUsers('Andhra Pradesh');
    // selStateValue = 'Andhra Pradesh';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    var email;
    var uId;
    try {
      appState = StateWidget.of(context).state;
      email = appState?.firebaseUserAuth?.email ?? '';

      uId = appState?.firebaseUserAuth?.uid ?? '';
      appState = StateWidget.of(context).state;
      var y = appState?.user;

      print('valuesa re there ${email}');
      // print('value of ${y?.dispName}');
      // // print('appState. ${appState.locationName}');
      // final locationName = appState?.locationName ?? 'Pick a place';
      // final hoName = appState?.hoName ?? '';
      // final soName = appState?.soName ?? '';
      // final stName = appState?.stName ?? '';

      // setState(() {
      //   locationText =
      //       locationName == '' ? 'Select ur preferred Location' : locationName;
      //   hoText = hoName == '' ? '' : hoName;
      //   soText = soName == '' ? '' : soName;
      //   stText = stName == '' ? '' : stName;
      // });
    } catch (e) {}

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              // begin: Alignment.bottomCenter,
              // end: Alignment.topCenter,
              colors: [Colors.greenAccent[200], Colors.blueAccent[200]]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: (){
                //     Navigator.pop(context);
                //   },
                //   icon: Icon(Icons.arrow_back_ios),
                //   iconSize: 15,
                //   color: Bid365AppTheme.WhiteHighEmphasis,
                // ),
                // SizedBox(height: 50),
                // Container(
                //   height: 150,
                //   width: double.infinity,
                //   child: ListView(
                //     children: [
                //       CarouselSlider(
                //         items: [
                //           Container(
                //             margin: EdgeInsets.all(6.0),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8.0),
                //                 image:DecorationImage(
                //                     image: AssetImage(
                //                       "assets/images/4.png",
                //                     ), fit: BoxFit.cover)
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.all(6.0),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8.0),
                //                 image: DecorationImage(
                //                     image: AssetImage(
                //                       "assets/images/4.png",
                //                     ), fit: BoxFit.cover)
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.all(6.0),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8.0),
                //                 image:DecorationImage(
                //                     image: AssetImage(
                //                       "assets/images/4.png",
                //                     ), fit: BoxFit.cover)
                //             ),
                //           ),
                //         ],
                //         //Slider Container properties
                //         options: CarouselOptions(
                //           height: 150.0,
                //           enlargeCenterPage: true,
                //           autoPlay: true,
                //           aspectRatio: 16 / 9,
                //           autoPlayCurve: Curves.fastOutSlowIn,
                //           enableInfiniteScroll: true,
                //           autoPlayAnimationDuration: Duration(milliseconds: 700),
                //           viewportFraction: 0.9,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 30),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Introducing regional leagues..!',
                        style: style5.copyWith(fontSize: 26),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          'We provide exclusive leagues for each region and there sub regions',
                          style: Bid365AppTheme.h4Slim.copyWith(
                            color: textColorB,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 30),
                        child: Text(
                          'Pick to view that zone and subzone contests',
                          style: Bid365AppTheme.h4Slim.copyWith(
                              fontSize: 18,
                              color: textColorB,
                              fontWeight: FontWeight.w500),
                        )),
                    //  Container(child: AnimTextPage()),
                    //        Image.asset('assets/images/${cityImg}',fit: BoxFit.fill,
                    // width: double.infinity,height: (180 / 815.0) * height),

//              Row(
//   mainAxisSize: MainAxisSize.min,
//   children: <Widget>[
//     SizedBox(width: 20.0, height: 100.0),
//     Text(
//       "Be",
//       style: TextStyle(fontSize: 43.0),
//     ),
//     SizedBox(width: 20.0, height: 100.0),
//     RotateAnimatedTextKit(
//       onTap: () {
//         print("Tap Event");
//       },
//       text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
//       textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
//       textAlign: TextAlign.start
//     ),

//   ],
// )
                  ],
                ),

                // SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: bgBlackShade,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 8.0, 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Pick a zone',
                                      style: style1.copyWith(fontSize: 18),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildStatePickerDropDown(context),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 22,
                          ),

                          Visibility(
                            visible: showLocality,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Pick District ',
                                        style: style1.copyWith(fontSize: 18),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        )
                                      : _buildLocalityPickerDropDown(context),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 22,
                          ),

                          Visibility(
                            visible: showLocality,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Pick Mandal ',
                                        style: style1.copyWith(fontSize: 18),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        )
                                      : _buildMandalPickerDropDown(context),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Visibility(
                            visible: showLocality,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Pick Village ',
                                        style: style1.copyWith(fontSize: 18),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        )
                                      : _buildVillageDropDown(context),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 22,
                          ),
                          Visibility(
                            visible: showLocality,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Grama Sachivalayam ',
                                        style: style1.copyWith(fontSize: 18),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        )
                                      : _buildGramaDropDown(context),
                                ],
                              ),
                            ),
                          ),

                          // Padding(

                          //  padding: const EdgeInsets.symmetric(horizontal: 40),

                          //   child: Container(

                          //     child: loading

                          //         ? CircularProgressIndicator(backgroundColor: Colors.black,)

                          //         : searchTextField = AutoCompleteTextField<User1>(

                          //             key: key,

                          //             clearOnSubmit: false,

                          //             suggestions: users,

                          //             style: TextStyle(color: Colors.white, fontSize: 16.0),

                          //             decoration: InputDecoration(

                          //             enabledBorder: OutlineInputBorder(

                          //               borderRadius: BorderRadius.all(Radius.circular(8)),

                          //               borderSide: BorderSide(width: 1,color: Colors.white),

                          //             ),

                          //             border: OutlineInputBorder(

                          //                 borderRadius: BorderRadius.all(Radius.circular(8)),

                          //                 borderSide: BorderSide(width: 1,)

                          //             ),

                          //             errorBorder: OutlineInputBorder(

                          //                 borderRadius: BorderRadius.all(Radius.circular(8)),

                          //                 borderSide: BorderSide(width: 1,color: Colors.black)

                          //             ),

                          //             focusedErrorBorder: OutlineInputBorder(

                          //                 borderRadius: BorderRadius.all(Radius.circular(8)),

                          //                 borderSide: BorderSide(width: 1,color: Colors.red)

                          //             ),

                          //             focusedBorder: OutlineInputBorder(

                          //               borderRadius: BorderRadius.all(Radius.circular(8)),

                          //               borderSide: BorderSide(width: 1,color: Bid365AppTheme.PrimaryRust),

                          //             ),

                          //             disabledBorder: OutlineInputBorder(

                          //               borderRadius: BorderRadius.all(Radius.circular(8)),

                          //               borderSide: BorderSide(width: 1,color: Bid365AppTheme.Disabled),

                          //             ),

                          //             labelText: "Locality ",

                          //             labelStyle: style2,

                          //           ),

                          //             itemFilter: (item, query) {

                          //               return item.name

                          //                   .toLowerCase()

                          //                   .startsWith(query.toLowerCase());

                          //             },

                          //             itemSorter: (a, b) {

                          //               return a.name.compareTo(b.name);

                          //             },

                          //             itemSubmitted: (item)  {

                          //               setState(() {

                          //                 searchTextField.textField.controller.text = item.name;

                          //               });

                          //               //      print('test ${StateWidget.of(context).state.locationId}');

                          //                _userLocationUpdate(locationName: searchTextField.textField.controller.text, locatonId: item.id, soId:item.soId, soName: item.soName, hoId: item.hoId, hoName: item.hoName, context: context, );

                          //               // print("searchTextField.textField.controller.text ${searchTextField.textField.controller.text} ${item.id}");

                          //             },

                          //             itemBuilder: (context, item) {

                          //               // ui for the autocompelete row

                          //               return row(item);

                          //             },

                          //           ),

                          //   ),

                          // ),

                          SizedBox(height: 12),

                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                child: Text(
                              '*more places coming soon..!',
                              style: style4.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            )),
                          ),

                          InkWell(
                            onTap: () {
                              print('selected values are ${selDistrictName}');
                              print('selected values are ${selMandalName}');
                              print('selected values are ${selDistrictName}');
                              print('selected values are ${selVillageName}');

                              // save this to db
                              DbQuery.instanace.updateVolunteerDetails(
                                  uId,
                                  stateId,
                                  selDistrictName,
                                  selMandalName,
                                  selVillageName,
                                  selSachivalayam);

                              _userLocationUpdate(
                                 stateId: stateId,
                                  selDistrictName:selDistrictName,
                                  selMandalName:selMandalName,
                                  selVillageName:selVillageName,
                                  selSachivalayam:selSachivalayam,
                                  context: context,);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomNavScreen(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 29, left: 40, right: 40),
                              child: Container(
                                height: 48,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),

                                    //border: Border.all(width:1, color:primary),

                                    color: primary),
                                child: Center(
                                    child: Text(
                                  'SET YOUR AREA',
                                  style: style3.copyWith(color: textColorB),
                                )),
                              ),
                            ),
                          ),

                          //         Row(

                          //       children: [

                          //         Expanded(

                          //           child: Padding(

                          //             padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),

                          //             child: Text('Can you Win in regional contests ?',style: style5.copyWith(fontSize: 22),),

                          //           ),

                          //          ),

                          //         //  Container(child: AnimTextPage()),

                          //        Expanded(

                          //          child:  Image.asset('assets/images/${cityImg}',fit: BoxFit.fill,

                          // width: double.infinity,height: (180 / 815.0) * height),

                          //        ),

                          //       ])
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

//  var stateNamesList = ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Delhi','Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu & Kashmir', 'Jharkhand','Karnataka','Kerala','Ladakh','Lakshadeep' 'Madhya Pradesh',
//  'Maharashtra', 'Manipur','Meghalaya','Mizoram', 'Nagaland', 'Odisha','Puducherry','Punjab','Rajasthan', 'Sikkim','Tripura', 'Uttarakhand', 'Uttar Pradesh', 'West Bengal', 'Andaman and Nicobar Islands', 'Dadra and Nagar Haveli and Daman & Diu'];
  var stateNamesList = [
    'Andhra Pradesh',
    'Karnataka',
    'Kerala',
    'Rajasthan',
    'West Bengal'
  ];
  Widget _buildStatePickerDropDown(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textColorW,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            8.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textColorW,
                        size: 20,
                      ),
                      underline: SizedBox(),
                      hint: selStateValue == null
                          ? Text(
                              'Pick State',
                              style: style1.copyWith(color: textColorW),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selStateValue,
                                style: style2,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 10.0,
                      style: TextStyle(color: Colors.blue),
                      items: ['Andhra Pradesh', 'Telanganaa'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                              val,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            print('value is val ${val}');
                            loading = true;
                            getUsers(val);
                            // getCityImage(val);
                            selStateValue = val;
                            // _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocalityPickerDropDown(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textColorW,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            8.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textColorW,
                        size: 20,
                      ),
                      underline: SizedBox(),
                      hint: selDistrictName['hoName'] == ""
                          ? Text(
                              'Select ur District',
                              style: style2,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selDistrictName['hoName'],
                                style: style2,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 10.0,
                      style: TextStyle(color: Colors.blue),
                      items: showSelDistricts.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val['hoName'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            print('value is val ${val}');
                            selDistrictName = val;
                            selDistrictId = val['hoid'];
                            showSelMandals = soObjFull
                                .where((doc) => doc["hoid"] == val['hoid'])
                                .toList();
                            print('showSelMandals ${showSelMandals}');
                            // _userLocationUpdate(
                            //   locationName: val['name'],
                            //   locatonId: val['id'],
                            //   soId: val['stId'],
                            //   soName: val['stName'],
                            //   hoId: val['hoid'],
                            //   hoName: val['hoName'],
                            //   stName: val['stName'],
                            //   stId: val['stId'],
                            //   context: context,
                            // );
                            // selLocValue = val['name'];
                            // _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMandalPickerDropDown(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textColorW,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            8.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textColorW,
                        size: 20,
                      ),
                      underline: SizedBox(),
                      hint: selMandalName['soName'] == ""
                          ? Text(
                              'Select ur Mandal',
                              style: style2,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selMandalName['soName'],
                                style: style2,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 10.0,
                      style: TextStyle(color: Colors.blue),
                      items: showSelMandals.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val['soName'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            print('value is val ${val}');
                            selMandalName = val;
                            selMandalId = val['soid'];
                            showSelVillages = boObjFull
                                .where((doc) => doc["soid"] == val['soid'])
                                .toList();
                            // _userLocationUpdate(
                            //   locationName: val['name'],
                            //   locatonId: val['id'],
                            //   soId: val['stId'],
                            //   soName: val['stName'],
                            //   hoId: val['hoid'],
                            //   hoName: val['hoName'],
                            //   stName: val['stName'],
                            //   stId: val['stId'],
                            //   context: context,
                            // );
                            // selLocValue = val['name'];
                            // _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVillageDropDown(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textColorW,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            8.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textColorW,
                        size: 20,
                      ),
                      underline: SizedBox(),
                      hint: selVillageName['boName'] == ""
                          ? Text(
                              'Select village region',
                              style: style2,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selVillageName['boName'],
                                style: style2,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 10.0,
                      style: TextStyle(color: Colors.blue),
                      items: showSelVillages.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val['boName'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            print('value is val ${val}');
                            selVillageName = val;

                            showGramaSac = sacObjFull
                                .where((doc) => doc["boid"] == val['boid'])
                                .toList();
                            // _userLocationUpdate(
                            //   locationName: val['name'],
                            //   locatonId: val['id'],
                            //   soId: val['stId'],
                            //   soName: val['stName'],
                            //   hoId: val['hoid'],
                            //   hoName: val['hoName'],
                            //   stName: val['stName'],
                            //   stId: val['stId'],
                            //   context: context,
                            // );
                            // selLocValue = val['name'];
                            // _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGramaDropDown(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textColorW,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            8.0) //                 <--- border radius here
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textColorW,
                        size: 20,
                      ),
                      underline: SizedBox(),
                      hint: selSachivalayam['sacName'] == ""
                          ? Text(
                              'Select village region',
                              style: style2,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selSachivalayam['sacName'],
                                style: style2,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 10.0,
                      style: TextStyle(color: Colors.blue),
                      items: showGramaSac.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val['sacName'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            print('value is val ${val}');
                            selSachivalayam = val;
                            // _userLocationUpdate(
                            //   locationName: val['name'],
                            //   locatonId: val['id'],
                            //   soId: val['stId'],
                            //   soName: val['stName'],
                            //   hoId: val['hoid'],
                            //   hoName: val['hoName'],
                            //   stName: val['stName'],
                            //   stId: val['stId'],
                            //   context: context,
                            // );
                            // selLocValue = val['name'];
                            // _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _userLocationUpdate(
      {stateId,
      selDistrictName,
      selMandalName,
      selVillageName,
      selSachivalayam,
      BuildContext context}) {
    try {
      var sname = stateId['sName'];
      var dname = selDistrictName['hoName'];
      var mname = selMandalName['soName'];
      var vname = selVillageName['boName'];
      var gsname = selSachivalayam['sacName'];

      var sId = stateId['sId'];
      var dId = selDistrictName['hoid'];
      var mId = selMandalName['soid'];
      var vId = selVillageName['boid'];
      var gsId = selSachivalayam['sacid'];

      print('check the local save ${sname}');
      print('check the local save ${dname}');
      print('check the local save ${mname}');
      print('check the local save ${vname}');
      print('check the local save ${gsname}');

      print('check the local save id=>  ${sId}');
      print('check the local save id=>  ${dId}');
      print('check the local save id=>  ${mId}');
      print('check the local save id=>  ${vId}');
      print('check the local save id=>  ${gsId}');

      StateWidget.of(context).userLocation(
        sname,
        dname,
        mname,
        vname,
        gsname,
        sId,
        dId,
        mId,
        vId,
        gsId
      );
    } catch (e) {
      print("locatin set error: $e");
    }
  }

  Widget row(user) {
    return ListTile(
      leading: Icon(Icons.location_city),
      // title: RichText(text:
      //  TextSpan(
      //   text: user.name.substring(0,searchTextField.textField.controller.text.length),
      //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //   children: [TextSpan(
      //     text:user.name.substring(searchTextField.textField.controller.text.length),
      //     style: TextStyle(color:Colors.grey)

      //   )]

      //    ),
      title: Text(
        user.name,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
