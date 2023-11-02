import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> dataList = [];
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String userId = _auth.currentUser!.uid;
    QuerySnapshot querySnapshot =
    await users.where('userId', isEqualTo: userId).get();

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data() as Map<String, dynamic>);
    }
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text("No data available.");
          } else {
            List<FlSpot> glucoseData = [];
            for (int i = 0; i < snapshot.data!.length; i++) {
              double glucose =
                  double.tryParse(snapshot.data![i]['glucose']) ?? 0.0;
              glucoseData.add(FlSpot(i.toDouble(), glucose));
            }

            return LineChart(
              LineChartData(
                gridData: const FlGridData(
                  show: true,
                  horizontalInterval: 100,
                  verticalInterval: 1,
                ),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 100,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                minX: 0,
                maxX: snapshot.data!.length.toDouble() - 1,
                minY: 0,
                maxY: 500,
                lineBarsData: [
                  LineChartBarData(
                    spots: glucoseData,
                    isCurved: true,
                    color: ColorConstants.accentColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    dotData: const FlDotData(show: true),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
