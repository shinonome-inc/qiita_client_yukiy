import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qiita_client_yukiy/models/article.dart';
import 'package:qiita_client_yukiy/ui_components/grey_article_part.dart';
import 'package:qiita_client_yukiy/ui_components/modal_article.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView(
      {Key? key,
      required this.articles,
      required this.scrollController,
      required this.itemCount,
      this.showGreyPart = false,
      this.showImage = true})
      : super(key: key);
  final ScrollController scrollController;
  final List<Article> articles;
  final int itemCount;
  final bool showGreyPart;
  final bool showImage;

  String subtitle(Article article) {
    final dateTime = DateTime.parse(article.dateTime);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final postedTime = dateFormat.format(dateTime);
    return '@${article.user.id} 投稿日:$postedTime いいね:${article.likesCount}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == articles.length) {
          return _loadingView();
        }
        final article = articles[index];
        return Column(
          children: [
            if (index == 0 && showGreyPart) GreyArticlePart(),
            listTile(article, context, showImage: showImage),
            const Divider(
              color: Color.fromRGBO(178, 178, 178, 1),
              thickness: 0.5,
              height: 8,
              indent: 20,
            ),
          ],
        );
      },
    );
  }

  Widget _loadingView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  Widget switchImage(Article article) {
    return SizedBox(
      child: CachedNetworkImage(
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
    );
  }

  listTile(Article article, BuildContext context, {required bool showImage}) {
    double? deviceHeight = MediaQuery.of(context).size.height;
    return ListTile(
      leading: showImage ? switchImage(article) : null,
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
                text: 'article',
              ),
            );
          },
        );
      },
    );
  }
}
