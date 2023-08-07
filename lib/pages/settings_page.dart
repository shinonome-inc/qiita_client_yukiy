import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget customDivider() {
    return const Divider(
      color: Color(0xFFE0E0E0),
      thickness: 0.5,
      indent: 5,
      height: 0,
    );
  }

  Widget settingList(String listText, void Function()? onPressed) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListTile(
          tileColor: Colors.white,
          dense: true,
          contentPadding: const EdgeInsets.only(left: 16),
          title: Text(
            listText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          trailing: IconButton(
            constraints: const BoxConstraints(),
            splashRadius: 20,
            icon: const ImageIcon(
              AssetImage('assets/images/vector.png'),
              color: Colors.black,
              size: 24,
            ),
            onPressed: onPressed,
          )),
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
    );
  }
}
