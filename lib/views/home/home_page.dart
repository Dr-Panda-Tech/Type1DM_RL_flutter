import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double glucoseLevel = 110.0;
  final double insulinIntake = 5.0;
  final String mealSummary = '朝: パン, 昼: ラーメン, 夕: サラダ';
  final String exerciseSummary = '30分のランニング';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildCard(
              title: '今日の血糖値',
              value: '$glucoseLevel mg/dL',
              icon: Icons.timeline,
            ),
            _buildCard(
              title: 'インスリン摂取量',
              value: '$insulinIntake units',
              icon: Icons.opacity,
            ),
            _buildCard(
              title: '食事サマリー',
              value: mealSummary,
              icon: Icons.fastfood,
            ),
            _buildCard(
              title: '運動サマリー',
              value: exerciseSummary,
              icon: Icons.run_circle,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildCard(
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

  Widget _buildCard({required String title, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 5.0,
        color: ColorConstants.pandaGreen,
        child: ListTile(
          leading: Icon(icon, size: 40.0, color: ColorConstants.accentColor),
          title: Text(title, style: kLabelTextStyle),
          subtitle: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
