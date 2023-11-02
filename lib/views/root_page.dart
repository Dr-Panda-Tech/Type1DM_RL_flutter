import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/home/home_page.dart';
import 'package:type1dm_rl_flutter/views/record/record_page.dart';
import 'package:type1dm_rl_flutter/views/graph/graph_page.dart';
import 'package:type1dm_rl_flutter/views/news/news_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GraphPage(),
    RecordPage(),
    NewsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:ColorConstants.backgroundColor,
        body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // floatingActionButton: Material(
      //   color: Colors.transparent,
      //   child: InkWell(
      //     borderRadius: BorderRadius.circular(40),  // これはContainerのborderRadiusと同じでなければなりません
      //     onTap: () {
      //       _onItemTapped(2);  // 2はRecordPageのインデックス
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.only(bottom: 0),
      //       child: Container(
      //         height: 70,
      //         width: 70,
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: [
      //               ColorConstants.accentColor.withOpacity(1.0),
      //               ColorConstants.accentColor,
      //             ],
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ),
      //           borderRadius: BorderRadius.circular(40),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.2),
      //               offset: Offset(0, 10),
      //               blurRadius: 10,
      //               spreadRadius: 3,
      //             )
      //           ],
      //         ),
      //         child: const FittedBox(
      //           fit: BoxFit.none,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(Icons.edit, size: 30, color: Colors.white),
      //               Text("記録", style: TextStyle(color: Colors.white, fontSize: 12)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontSize: 9),  // 選択されたアイテムのテキストサイズ
        unselectedLabelStyle: TextStyle(fontSize: 9),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '血糖推移',
          ),
          BottomNavigationBarItem(
            // icon: Container(height: 0), // 中央のアイコンを空に
            icon: Icon(Icons.edit),
            label: '記録',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'ニュース',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'プロフィール',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.accentColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
