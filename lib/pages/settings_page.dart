import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget customDivider() {
    return const Divider(
      color: Color(0xFFE0E0E0),
      thickness: 0.5,
      indent: 16,
    );
  }

  Widget settingList(String listText, void Function()? onPressed) {
    return Row(
      children: [
        Text(listText),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: onPressed,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: UpperBar(
        showSearchBar: false,
        appBarText: 'Settings',
        textField: const TextField(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 16),
                child: const Text(
                  'アプリ情報',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF828282),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              settingList(
                "プライバシーポリシー",
                () {
                  //プライバシーポリシー
                },
              ),
              customDivider(),
              settingList(
                "利用規約",
                () {
                  //利用規約
                },
              ),
              customDivider(),
              settingList(
                "アプリバージョン",
                () {
                  //アプリバージョン
                },
              ),
              customDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
