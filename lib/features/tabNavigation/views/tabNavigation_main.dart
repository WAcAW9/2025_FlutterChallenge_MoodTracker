// 네비게이션 바 스크린
import 'package:flutter/material.dart';
import 'package:mood_tracker/features/tabNavigation/views/article_show_screen.dart';
import 'package:mood_tracker/features/tabNavigation/views/article_write_screen.dart';
import 'package:mood_tracker/features/tabNavigation/views/settings_screen.dart';

class TabnavigationMain extends StatefulWidget {
  static const routeName = "/home";
  const TabnavigationMain({super.key});

  @override
  State<TabnavigationMain> createState() => _TabnavigationMainState();
}

class _TabnavigationMainState extends State<TabnavigationMain> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [
    ArticleShowScreen(),
    ArticleWriteScreen(),
    UserScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
            tooltip: "무드 보기",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            tooltip: "무드 작성하기",
            label: "write",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            tooltip: "설정",
            label: "Settings",
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
