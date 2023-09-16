import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qiita_client_yukiy/constants/modal_text.dart';
import 'package:qiita_client_yukiy/pages/top_page.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';
import 'package:qiita_client_yukiy/ui_components/variable_height_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var text = 'v${packageInfo.version}';
    return text;
  }

  Widget customDivider() {
    return const Divider(
      color: Color(0xFFE0E0E0),
      thickness: 0.5,
      indent: 16,
      height: 0,
    );
  }

  Widget modalContentWidget(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 11),
          alignment: Alignment.bottomCenter,
          height: 59,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style:
                const TextStyle(fontFamily: 'Pacifico-Regular', fontSize: 17),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(content),
            ),
          ),
        ),
      ],
    );
  }

  Widget modalTriggerTile(
      BuildContext context, Widget selectModal, String listTitle) {
    return VariableHeightListTile(
      onTap: () {
        double? deviceHeight = MediaQuery.of(context).size.height;
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
              child: selectModal,
            );
          },
        );
      },
      title: listTitle,
      trailing: const ImageIcon(
        AssetImage('assets/images/vector.png'),
        color: Colors.black,
        size: 24,
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    print("ログアウトしました");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TopPage()),
    );
  }

  Future<void> confirmLogout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('ログアウトの確認'),
          content: const Text('本当にログアウトしますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ログアウト'),
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: const UpperBar(
        showSearchBar: false,
        appBarText: 'Settings',
        textField: TextField(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SettingSectionHeader(text: "アプリ情報"),
          modalTriggerTile(
            context,
            modalContentWidget("プライバシーポリシー", ModalText.privacyPolicy),
            "プライバシーポリシー",
          ),
          customDivider(),
          modalTriggerTile(
            context,
            modalContentWidget("利用規約", ModalText.termsOfService),
            "利用規約",
          ),
          customDivider(),
          VariableHeightListTile(
            title: "アプリバージョン",
            trailing: FutureBuilder<String>(
              future: getVersionInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data : '受け取れてません',
                );
              },
            ),
          ),
          customDivider(),
          FutureBuilder<bool>(
            future: QiitaClient.switchPage(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              final isLoggedIn = snapshot.data ?? false;
              if (isLoggedIn) {
                return Column(
                  children: [
                    const SettingSectionHeader(text: "その他"),
                    VariableHeightListTile(
                      title: "ログアウトする",
                      trailing: const SizedBox.shrink(),
                      onTap: () {
                        confirmLogout(context);
                      },
                    ),
                    customDivider(),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class SettingSectionHeader extends StatelessWidget {
  final String text;

  const SettingSectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 32, bottom: 8, left: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF828282),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
