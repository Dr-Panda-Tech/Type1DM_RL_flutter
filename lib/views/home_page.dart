import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ダミーデータ
  final double glucoseLevel = 110.0; // 血糖値
  final double insulinIntake = 5.0; // インスリン摂取量
  final String mealSummary = '朝: パン, 昼: ラーメン, 夕: サラダ'; // 食事サマリー
  final String exerciseSummary = '30分のランニング'; // 運動サマリー

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: const Text('今日の血糖値'),
                subtitle: Text('$glucoseLevel mg/dL'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('インスリン摂取量'),
                subtitle: Text('$insulinIntake units'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('食事サマリー'),
                subtitle: Text(mealSummary),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('運動サマリー'),
                subtitle: Text(exerciseSummary),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'アドバイス:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '今日の血糖値は安定しています。適切な食事と運動を続けてください。',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
