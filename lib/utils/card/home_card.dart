import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Widget buildGlucoseCard() {
  String getFormattedDate() {
    DateTime now = DateTime.now();
    return '${now.year}/${now.month}/${now.day}';
  }

  final Map<String, double> glucoseLevels = {
    '朝': 110.0,
    '昼': 105.0,
    '夕': 108.0,
    '眠前': 100.0,
  };
  final Map<String, String> insulinDetails = {
    '朝': 'ノボラピッド - 5',
    '昼': 'ノボラピッド - 4',
    '夕': 'ノボラピッド - 5',
    '眠前': 'グラルギン - 6',
  };

  return Card(
    elevation: 5.0,
    color: ColorConstants.pandaGreen,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, size: 18.0),  // adjust size as needed
              onPressed: () {
                // 前の日のデータを表示する処理を書く
              },
            ),
            Text('${getFormattedDate()}の血糖管理', style: kLabelTextStyle),
            IconButton(
              icon: Icon(Icons.arrow_forward, size: 18.0),  // adjust size as needed
              onPressed: () {
                // 翌日のデータを表示する処理を書く
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey.shade300), // adjust border color
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                // decoration: BoxDecoration(
                //   color: Colors.grey.shade200,  // adjust background color for header
                // ),
                children: [
                  Text('時間', style: kTableLabelTextStyle, textAlign: TextAlign.center),
                  Text('血糖値(mg/dL)', style: kTableLabelTextStyle, textAlign: TextAlign.center),
                  Text('インスリン', style: kTableLabelTextStyle, textAlign: TextAlign.center),
                  Text('単位数', style: kTableLabelTextStyle, textAlign: TextAlign.center),
                ],
              ),
              ...glucoseLevels.keys.map((key) {
                final insulinDetailsList = insulinDetails[key]!.split(' - ');
                return TableRow(
                  children: [
                    Text(key, textAlign: TextAlign.center),
                    Text('${glucoseLevels[key]}', textAlign: TextAlign.center),
                    Text(insulinDetailsList[0], textAlign: TextAlign.center),
                    Text(insulinDetailsList[1], textAlign: TextAlign.center),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCard(
    {required String title, required String value, required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Card(
      elevation: 5.0,
      color: ColorConstants.pandaGreen,
      child: ListTile(
        leading: Icon(icon, size: 40.0, color: ColorConstants.pandaGreen),
        title: Text(title, style: kLabelTextStyle),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    ),
  );
}

