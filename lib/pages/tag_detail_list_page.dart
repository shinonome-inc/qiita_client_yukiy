import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class TagDetailListPage extends StatefulWidget {
  const TagDetailListPage({Key? key, required this.tagName}) : super(key: key);
  final String tagName;

  @override
  State<TagDetailListPage> createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperBar(
        appBarText: widget.tagName,
        textField: const TextField(),
      ),
    );
  }
}
