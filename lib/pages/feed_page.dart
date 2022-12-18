import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/search_bar.dart';

import '../models/article.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchBar(
        text: 'Search',
      ),
      body: ArticleListPage(),
    );
  }
}

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<List<Article>> articles;
  @override
  void initState() {
    articles = QiitaClient.fetchArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class ArticleListView extends StatelessWidget {
  final List<Article> articles;
  const ArticleListView({Key? key, required this.articles}) : super(key: key);

  String subtitle(Article article) {
    final dateTime = DateTime.parse(article.dateTime);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final postedTime = dateFormat.format(dateTime);
    return '@${article.user.id} 投稿日:$postedTime いいね:${article.likesCount}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articles[index];
        return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(article.user.iconUrl),
            ),
            title: Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              subtitle(article),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color.fromRGBO(178, 178, 178, 1),
        thickness: 0.5,
        indent: 62,
      ),
    );
  }
}
