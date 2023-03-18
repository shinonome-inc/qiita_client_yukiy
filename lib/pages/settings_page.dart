import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperBar(
        showSearchBar: false,
        appBarText: 'Settings',
        textField: const TextField(),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
