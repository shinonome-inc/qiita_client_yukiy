import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/top_page.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../ui_components/thin_long_rounded_button.dart';

class UserNotLoginPage extends StatelessWidget {
  UserNotLoginPage({Key? key}) : super(key: key);
  late double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UpperBar(
        appBarText: 'MyPage',
        textField: TextField(),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight / 4, bottom: 6),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "ログインが必要です",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'マイページの機能を利用するには',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'ログインを行っていただく必要があります。',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight / 3),
              child: ThinLongRoundedButton(
                text: 'ログインする',
                backgroundColor: const Color(0xFF74C13A),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TopPage(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
