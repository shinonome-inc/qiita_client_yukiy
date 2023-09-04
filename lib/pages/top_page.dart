import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/bottom_navigation.dart';
import 'package:qiita_client_yukiy/ui_components/thin_long_rounded_button.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  late double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.2),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: screenHeight / 4,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Qiita Feed App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Pacifico-Regular',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    '-PlayGround-',
                    style: TextStyle(
                      letterSpacing: 0.25,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                ThinLongRoundedButton(
                  text: 'ログイン',
                  backgroundColor: const Color(0xFF468300),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ThinLongRoundedButton(
                  text: 'ログインせずに利用する',
                  backgroundColor: Colors.transparent,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 81,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
