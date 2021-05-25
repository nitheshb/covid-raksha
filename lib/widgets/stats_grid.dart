import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildStatCard('Total Orders', '1.81 M', Color(0xffFF8A5E)),
              _buildStatCard('Total Delivered', '105 K', Color(0xff4FE5B8)),
            ],
          ),
          Row(
            children: <Widget>[
              _buildStatCard('L', '391 K', Colors.blueGrey),
              _buildStatCard('Med-1', '1.31 M', Colors.blueGrey),
              _buildStatCard('Med-2', 'N/A', Colors.blueGrey),
          
            ],
          ),
           Row(
             children: <Widget>[
               _buildStatCard('Recovered', '391 K',Color(0xff4FE5B8)),
               _buildStatCard('Active', '1.31 M', Color(0xffA66DFF)),
               _buildStatCard('Critical', 'N/A', Color(0xffFF8A5E)),
             ],
           ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count,  color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
