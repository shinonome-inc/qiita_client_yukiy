import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/bottom_navigation.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/modal_article.dart';
import 'package:qiita_client_yukiy/ui_components/thin_long_rounded_button.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key, this.code}) : super(key: key);
  final String? code;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  String? accessToken = '';
  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;
    accessToken = await QiitaClient.fetchAccessToken(widget.code!);
    await QiitaClient.saveAccessToken(accessToken!);
    print('accessToken💫 $accessToken');
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigation(),
      ),
    );
  }

  @override
  void initState() {
    if (widget.code != null) {
      login();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
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
                  height: deviceHeight / 4,
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
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: deviceHeight * 0.9,
                          child: ModalArticle(
                              url: QiitaClient.fetchLogin(),
                              text: "Qiita Auth"),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ThinLongRoundedButton(
                  text: 'ログインせずに利用する',
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()),
                    );
                  },
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
