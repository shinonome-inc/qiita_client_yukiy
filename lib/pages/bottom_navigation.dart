import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/user_not_login_page.dart';

import 'feed_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _selectIndex = 0;

  final _pages = <Widget>[
    const FeedPage(),
    Container(
      alignment: Alignment.center,
      child: const Text('タグ'),
    ),
    const UserNotLoginPage(),
    Container(
      alignment: Alignment.center,
      color: Colors.pink.withOpacity(0.5),
      child: const Text('設定'),
    ),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(width: 0.5, color: Color(0xFF828282)),
        )),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted_outlined,
              ),
              label: 'フィード',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.label_outline,
              ),
              label: 'タグ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'マイページ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: '設定',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectIndex,
          unselectedItemColor: const Color(0xFF828282),
          selectedItemColor: const Color(0xFF74C13A),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: _onTapItem,
        ),
      ),
    );
  }
}
