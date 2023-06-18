import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/user_not_login_page.dart';
import 'package:qiita_client_yukiy/pages/user_page.dart';

import '../services/qiita_client.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isLogin = true;

  @override
  void initState() {
    Future(() async {
      isLogin = await QiitaClient.switchPage();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLogin ? const UserPage() : UserNotLoginPage(),
      ),
    );
  }
}
