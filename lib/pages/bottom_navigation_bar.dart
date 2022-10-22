import 'package:flutter/material.dart';

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
    Container(
      alignment: Alignment.center,
      color: Colors.lightBlue,
      child: const Text('マイページ'),
    ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined,
                color: Color.fromRGBO(130, 130, 130, 1)),
            label: 'フィード',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline,
                color: Color.fromRGBO(130, 130, 130, 1)),
            label: 'タグ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,
                color: Color.fromRGBO(130, 130, 130, 1)),
            label: 'マイページ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(130, 130, 130, 1),
            ),
            label: '設定',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onTapItem,
      ),
    );
  }
}
