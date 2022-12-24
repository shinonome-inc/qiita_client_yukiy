import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_client_yukiy/models/article.dart';

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
