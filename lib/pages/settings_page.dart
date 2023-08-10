import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';
import 'package:qiita_client_yukiy/ui_components/variable_height_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget customDivider() {
    return const Divider(
      color: Color(0xFFE0E0E0),
      thickness: 0.5,
      indent: 16,
      height: 0,
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
          VariableHeightListTile(
            title: "プライバシーポリシー",
            trailing: CustomIconButton(
              onPressed: () {},
            ),
          ),
          customDivider(),
          VariableHeightListTile(
            title: "利用規約",
            trailing: CustomIconButton(
              onPressed: () {},
            ),
          ),
          customDivider(),
          const VariableHeightListTile(
            title: "アプリバージョン",
            trailing: Text('バージョン'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 32, bottom: 8, left: 16),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF828282),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
