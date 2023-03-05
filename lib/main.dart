import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/tag_detail_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita client yukiy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TagDetailListPage(
        tagName: "転職",
      ),
    );
  }
}
