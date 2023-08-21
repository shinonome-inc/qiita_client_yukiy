import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../ui_components/thin_long_rounded_button.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key}) : super(key: key);
  late final double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UpperBar(
        appBarText: '',
        textField: const TextField(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 36),
            height: 80,
            width: 80,
            child: Image.asset('assets/images/network_error.png'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "ネットワークエラー",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'お手数ですが電波の良い場所で',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '再度読み込みをお願いします。',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: screenHeight / 3.5),
            child: ThinLongRoundedButton(
              text: '再読み込みする',
              backgroundColor: const Color(0xFF74C13A),
              onPressed: () {},
            ),
          ),
          Container(
            height: 32,
          ),
        ],
      ),
    );
  }
}
