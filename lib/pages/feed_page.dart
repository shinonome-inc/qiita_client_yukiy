import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/article_list_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late Future<List<Article>> articles;
  @override
  void initState() {
    articles = QiitaClient.fetchArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperBar(
        showSearchBar: true,
        appBarText: 'Feed',
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ArticleListView(articles: snapshot.data!);
            } else if (snapshot.hasError) {
              return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
