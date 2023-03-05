import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_client_yukiy/models/article.dart';
import 'package:qiita_client_yukiy/ui_components/modal_article.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView(
      {Key? key,
      required this.articles,
      required this.scrollController,
      required this.itemCount})
      : super(key: key);
  final ScrollController scrollController;
  final List<Article> articles;
  final int itemCount;

  String subtitle(Article article) {
    final dateTime = DateTime.parse(article.dateTime);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final postedTime = dateFormat.format(dateTime);
    return '@${article.user.id} 投稿日:$postedTime いいね:${article.likesCount}';
  }

  @override
  Widget build(BuildContext context) {
    double? deviceHeight = MediaQuery.of(context).size.height;
    return ListView.separated(
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == articles.length) {
          return _loadingView();
        }
        final article = articles[index];
        return ListTile(
          leading: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: article.user.iconUrl,
            width: 38,
            height: 38,
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
          ),
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SizedBox(
                  height: deviceHeight * 0.9,
                  child: ModalArticle(
                    url: article.url,
                  ),
                );
              },
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color.fromRGBO(178, 178, 178, 1),
        thickness: 0.5,
        indent: 62,
      ),
    );
  }

  Widget _loadingView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
