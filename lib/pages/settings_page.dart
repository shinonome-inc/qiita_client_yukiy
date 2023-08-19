import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qiita_client_yukiy/constants/modal_text.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';
import 'package:qiita_client_yukiy/ui_components/variable_height_list_tile.dart';

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

  Widget settingModal(String title, String content) {
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

  Widget listName(BuildContext context, Widget selectModal, String listTitle) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomSettingName(text: "アプリ情報"),
          listName(
            context,
            settingModal("プライバシーポリシー", ModalText.privacyPolicy),
            "プライバシーポリシー",
          ),
          customDivider(),
          listName(
            context,
            settingModal("利用規約", ModalText.termsOfService),
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
          const CustomSettingName(text: "その他"),
          const VariableHeightListTile(
            title: "ログアウトする",
            trailing: SizedBox.shrink(),
          ),
          customDivider(),
        ],
      ),
    );
  }
}

class CustomSettingName extends StatelessWidget {
  final String text;

  const CustomSettingName({super.key, required this.text});

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
