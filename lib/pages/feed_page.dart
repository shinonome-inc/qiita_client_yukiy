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
  List<Article> listArticle = [];
  late Future<List<Article>> futureArticles;
  @override
  void initState() {
    futureArticles = QiitaClient.fetchArticle("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperBar(
        showSearchBar: true,
        appBarText: 'Feed',
        textField: TextField(
          onSubmitted: (value) {
            if (value.isEmpty) {
              print("https://qiita.com/api/v2/items");
            } else {
              setState(() {
                listArticle = [];
                futureArticles = QiitaClient.fetchArticle(value);
              });
              print(listArticle);
            }
          },
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(30, 7, 1, 7),
            fillColor: const Color.fromRGBO(118, 118, 128, 0.12),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            iconColor: const Color.fromRGBO(142, 142, 147, 0),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              letterSpacing: -0.408,
              fontFamily: "Noto_Sans_JP",
            ),
          ),
        ),
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
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
