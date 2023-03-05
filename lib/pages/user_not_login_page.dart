import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class UserNotLoginPage extends StatelessWidget {
  const UserNotLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UpperBar(
        appBarText: 'MyPage',
        textField: TextField(),
      ),
    );
  }
}
