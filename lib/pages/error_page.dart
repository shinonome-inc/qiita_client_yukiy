import 'package:flutter/material.dart';

import '../ui_components/thin_long_rounded_button.dart';
import '../ui_components/upper_bar.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key, required this.onTapped}) : super(key: key);
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const UpperBar(
        showSearchBar: false,
        appBarText: '',
        textField: TextField(),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          SizedBox(height: screenHeight / 7),
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/images/network_error.png'),
          ),
          const SizedBox(
            height: 36,
          ),
          const Text(
            "ネットワークエラー",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
            style: TextStyle(
              fontSize: 12,
              height: 2,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
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
