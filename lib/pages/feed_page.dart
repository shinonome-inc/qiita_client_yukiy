import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/search_bar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Widget _searchTextField() {
    return const TextField();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchBar(
        text: 'Search',
      ),
    );
  }
}
