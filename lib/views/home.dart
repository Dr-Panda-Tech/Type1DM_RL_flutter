import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/home_page.dart';
import 'package:type1dm_rl_flutter/views/record_page.dart';
import 'package:type1dm_rl_flutter/views/graph_page.dart';
import 'package:type1dm_rl_flutter/views/news_page.dart';
import 'package:type1dm_rl_flutter/views/profile_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          _onItemTapped(2); // 2はRecordPageのインデックス
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstants.accentColor.withOpacity(0.8),
                  ColorConstants.accentColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 8),
                  blurRadius: 10,
                  spreadRadius: 3,
                )
              ],
            ),
            child: const FittedBox(
              fit: BoxFit.none,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 30, color: Colors.white),
                  Text("Record",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Container(height: 0), // 中央のアイコンを空に
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
