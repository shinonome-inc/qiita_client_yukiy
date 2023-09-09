import 'package:flutter/material.dart';

import '../ui_components/thin_long_rounded_button.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key, required this.onTapped}) : super(key: key);
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 36),
            height: 80,
            width: 80,
            child: Image.asset('assets/images/network_error.png'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: const Text(
              "ネットワークエラー",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: const Text(
              'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
              style: TextStyle(
                fontSize: 12,
                height: 2,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: screenHeight / 3.5),
            child: ThinLongRoundedButton(
              text: '再読み込みする',
              backgroundColor: const Color(0xFF74C13A),
              onPressed: onTapped,
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