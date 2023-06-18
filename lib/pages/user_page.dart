import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/grey_article_part.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../services/qiita_client.dart';
import '../ui_components/article_list_view.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  String subtitle(Article article) {
    return '@${article.user.id}}';
  }

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Article> listArticle = [];
  Future<List<Article>>? futureArticles;
  int pageNumber = 1;
  late ScrollController _scrollController;
  late bool _isLoading = true;
  late final List<Article> articles;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    print("fetched");
    await Future.delayed(const Duration(seconds: 1));
    print('pageNumber is $pageNumber');
    _isLoading = false;
    futureArticles = QiitaClient.fetchArticle("", pageNumber);
    listArticle.addAll(await futureArticles!);
    print('表示件数: ${listArticle.length}');

    if (mounted) {
      setState(
        () {
          if (listArticle.isNotEmpty) {
            pageNumber++;
          }
        },
      );
    }
  }

  void _scrollListener() async {
    double positionRate =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
    const double threshold = 0.9;
    if (positionRate > threshold && !_isLoading) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      await _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: UpperBar(
          appBarText: 'MyPage',
          textField: const TextField(),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CachedNetworkImage(
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     margin: const EdgeInsets.only(bottom: 24),
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //         image: imageProvider,
                    //       ),
                    //     ),
                    //   ),
                    //   placeholder: (context, url) =>
                    //       const CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),
                    //   imageUrl: profileImageUrl,
                    //   width: 100,
                    //   height: 100,
                    // ),
                    const Text(
                      "ユーザー名",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: const Text(
                        "@UserId",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: const Text(
                        "User Description User DescriptionUser Description User Description User DescriptionUser Description User Description User DescriptionUser Descripti...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GreyArticlePart(),
              FutureBuilder<List<Article>>(
                future: futureArticles,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ArticleListView(
                      articles: listArticle,
                      scrollController: _scrollController,
                      itemCount: _isLoading
                          ? listArticle.length + 1
                          : listArticle.length,
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
