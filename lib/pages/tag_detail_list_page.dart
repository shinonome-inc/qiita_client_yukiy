import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/article_list_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../services/qiita_client.dart';

class TagDetailListPage extends StatefulWidget {
  const TagDetailListPage({Key? key, required this.tagName}) : super(key: key);
  final String tagName;

  @override
  State<TagDetailListPage> createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  List<Article> listArticle = [];
  late Future<List<Article>> futureArticles;
  @override
  void initState() {
    futureArticles = QiitaClient.fetchTag(widget.tagName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperBar(
        appBarText: widget.tagName,
        textField: const TextField(),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              listArticle = snapshot.data!;
              return ArticleListView(articles: listArticle);
            } else if (snapshot.hasError) {
              return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
            }
            print(snapshot.error);
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
