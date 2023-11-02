import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/card/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // 食事サマリー関連の変数
  final Map<String, String> mealSummaries = {
    '朝': 'パン',
    '昼': 'ラーメン',
    '夕': 'サラダ',
  };

  final String exerciseSummary = '30分のランニング';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 50.0),
            buildGlucoseCard(),
            buildCard(
              title: '運動サマリー',
              value: exerciseSummary,
              icon: Icons.run_circle,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: buildCard(
                  title: 'アドバイス',
                  value: '今日の血糖値は安定しています。適切な食事と運動を続けてください。',
                  icon: Icons.info_outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
