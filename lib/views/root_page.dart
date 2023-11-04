import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/home/home_page.dart';
import 'package:type1dm_rl_flutter/views/record/record_page.dart';
import 'package:type1dm_rl_flutter/views/graph/graph_page.dart';
import 'package:type1dm_rl_flutter/views/news/news_page.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GraphPage(),
    RecordPage(),
    NewsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontSize: 9),
        unselectedLabelStyle: TextStyle(fontSize: 9),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '血糖推移',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'ニュース',
          ),
          BottomNavigationBarItem(
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
