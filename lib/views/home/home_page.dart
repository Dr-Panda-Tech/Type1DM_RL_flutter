import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVGアイコンを利用するためのパッケージが必要
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

  // グラフ表示などの追加機能を実装する場所

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: ColorConstants.pandaBlack,
          onPressed: () {},
        ),
        title: Text(
          'ホーム',
          style: kColorTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: ColorConstants.pandaBlack,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25.0),
            HomeCard(title: '血糖値', value: '5.8 mmol/L', color: Colors.green, icon: Icons.show_chart),
            SizedBox(height: 20),
            ...mealSummaries.entries.map(
                  (entry) => HomeCard(
                title: '${entry.key}の食事',
                value: entry.value,
                color: Colors.blue,
                icon: Icons.restaurant_menu,
              ),
            ),
            SizedBox(height: 20),
            HomeCard(title: '運動サマリー', value: exerciseSummary, color: Colors.purple, icon: Icons.directions_run),
            SizedBox(height: 20),
            HomeCard(
              title: 'アドバイス',
              value: '今日の血糖値は安定しています。適切な食事と運動を続けてください。',
              color: Colors.teal,
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }

}

// HomeCard ウィジェットを新しくデザイン
class HomeCard extends StatelessWidget {
  final String title;
  final String value;
  final MaterialColor color;
  final IconData icon;

  const HomeCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
