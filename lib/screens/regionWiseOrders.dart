import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/config/palette.dart';
import 'package:flutter_covid_dashboard_ui/config/styles.dart';
import 'package:flutter_covid_dashboard_ui/data/data.dart';
import 'package:flutter_covid_dashboard_ui/screens/districtCard.dart';
import 'package:flutter_covid_dashboard_ui/widgets/donutPieChartAnim.dart';
import 'package:flutter_covid_dashboard_ui/widgets/waveEffect.dart';
import 'package:flutter_covid_dashboard_ui/widgets/widgets.dart';
import 'package:flutter_covid_dashboard_ui/util/sizeEffect.dart';
import 'package:charts_flutter/flutter.dart' as charts;
var data = [
  new DataPerItem('Home', 35, Colors.greenAccent),
  new DataPerItem('Food & Drink', 25, Colors.yellow),
  new DataPerItem('Hotel & Restaurant', 24, Colors.indigo),
  new DataPerItem('Travelling', 40, Colors.pinkAccent),
];

var series = [
  new charts.Series(
    domainFn: (DataPerItem clickData, _) => clickData.name,
    measureFn: (DataPerItem clickData, _) => clickData.percent,
    colorFn: (DataPerItem clickData, _) => clickData.color,
    id: 'Item',
    data: data,
  ),
];

class RegionWiseOrders extends StatefulWidget {
  @override
  _RegionWiseOrdersState createState() => _RegionWiseOrdersState();
}

class _RegionWiseOrdersState extends State<RegionWiseOrders> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      title: Text('Andhra Pradesh'),
   
    ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
         _buildHeader(),
        //  _buildRegionTabBar(),
         // _buildStatsTabBar(),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   sliver: SliverToBoxAdapter(
          //     child: StatsGrid(),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 0.0),
            sliver: SliverToBoxAdapter(
              child: ChatDisp(),
            ),
          ),

          districtCard(),

        ],
      ),
    );
  }


Widget ChatDisp(){
     final _media = MediaQuery.of(context).size;
  return Column(
    children: [
      RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Orders Stats",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Varela",
                      ),
                    ),
                 
                  ],
                ),
              ),
               Container(
            margin: EdgeInsets.only(
              top: 15,
              right: 20,
            ),
            height:
                screenAwareSize(_media.longestSide <= 775 ? 180 : 130, context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 6,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 180,
                  width: 160,
                  child: DonutPieChart(
                    series,
                    animate: true,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      donutCard(Colors.indigo, "L- 920"),
                      donutCard(Colors.yellow, "K-1230"),
                      donutCard(Colors.greenAccent, "F-234"),
                      donutCard(Colors.pinkAccent, "D-10"),
                    ],
                  ),
                )
              ],
            ),
          )
    ],
  );
         
}

  Widget donutCard(Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 18,
            right: 10,
          ),
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            inherit: true,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        )
      ],
    );
  }
  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Andhra Pradesh'),
              Text('Other States'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  SliverPadding districtCard() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
             RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "District-Wise Stats",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Varela",
                      ),
                    ),
                 
                  ],
                ),
              ),
            Column(
              children: [
                                          InkWell(
                              onTap: (){
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => DistrictWiseOrders(districtName: 'SPSR NELLORE')
                                    ));
                              },
                       child: vaweCard(
            context,
            "SPSR NELLORE",
            "L-10 | P-30 | K-100 | D-1000",
            200,
            1,
            Colors.grey.shade100,
            Color(0xFF716cff),
          ),
                     ),
          InkWell(
              onTap: (){
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => DistrictWiseOrders(districtName: 'ONGOLE')
                                    ));
                              },
            child: vaweCard(
              context,
              "ONGOLE",
              "L-200 | P-6K  | K-10K | D-0",
              100,
              1,
              Colors.grey.shade100,
              Color(0xFF716cff),
            ),
          ),
          vaweCard(
            context,
            "TIRUPATI",
            "L-93 | P-53 | K-76| D-34",
            200,
            1,
            Colors.grey.shade100,
            Color(0xFF716cff),
          ),
          vaweCard(
            context,
            "CUDDAPAH",
            "L-32 | P-1 | K-45 | D-45",
            200,
            1,
            Colors.grey.shade100,
            Color(0xFF716cff),
          ),
          vaweCard(
            context,
            "KRISHNA",
            "L-32 | P-12 | K-87 | D-45",
            200,
            1,
            Colors.grey.shade100,
            Color(0xFF716cff),
          ),
                // check('SPSR Nellore'),
                // check('ONGOLE'),
                // check('TIRUPATI'),
                // check('CUDDAPAH'),
                // check('KRISHNA'),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverPadding districtCard1() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
          child: Container(
        height: 130,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SPSR NELLORE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'CONFIRMED:' + 100.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  Text(
                    'ACTIVE:' + 200.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Text(
                    'RECOVERED:' + 300.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    'DEATHS:' + 10.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[100]
                            : Colors.grey[900]),
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }

  Widget check(distictName) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$distictName",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
              
                  Text(
                    'ORDERS:' + 100.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  Text(
                    'DELIVERY:' + 200.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  Text(
                    'RECOVERED:' + 300.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.greenAccent),
                  ),
                  Text(
                    'DEATHS:' + 10.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[100]
                            : Colors.grey[900]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget vaweCard(BuildContext context, String name, String status, double amount, int type,
      Color fillColor, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenAwareSize(45, context),
                fillColor,
                bgColor,
                67,
              ),
              Text(
                "80%",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
}
