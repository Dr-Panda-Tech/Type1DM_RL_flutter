import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/home/home_page.dart';
import 'package:type1dm_rl_flutter/views/record/record_page.dart';
import 'package:type1dm_rl_flutter/views/chat/select_chat_partner_page.dart';
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
    SelectChatPartnerPage(),
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
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 25),
            label: 'チャット',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit, size: 25),
            label: '記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, size: 25),
            label: 'ニュース',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 25),
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
