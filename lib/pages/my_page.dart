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
  bool? isLogin;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      isLogin = await QiitaClient.switchPage();
      setState(() {}); // isLoginの値が更新されたことを反映するためにsetStateを呼び出す
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    if (isLogin == null) {
      // isLoginがnullの場合はローディングなどを表示するウィジェットを返す
      return const CircularProgressIndicator();
    } else {
      return MaterialApp(
        home: Scaffold(
          body: isLogin! ? const UserPage() : UserNotLoginPage(),
        ),
      );
    }
  }
}
