import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/error_page.dart';
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
  Future<List<Article>>? futureArticles;
  late ScrollController _scrollController;
  late bool _isLoading = true;
  int pageNumber = 1;
  bool showGreyPart = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _initFetchData();
    super.initState();
  }

  Future<void> _initFetchData() async {
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
    return Scaffold(
      appBar: UpperBar(
        showSearchBar: true,
        appBarText: 'Feed',
        textField: TextField(
          onSubmitted: (value) async {
            if (value.isEmpty) {
              print("https://qiita.com/api/v2/items");
            } else {
              if (mounted) {
                setState(() {
                  listArticle = [];
                  pageNumber = 1;
                });
              }
              futureArticles = QiitaClient.fetchArticle(value, pageNumber);
              listArticle.addAll(await futureArticles!);
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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ArticleListView(
                articles: listArticle,
                scrollController: _scrollController,
                itemCount:
                    _isLoading ? listArticle.length + 1 : listArticle.length,
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return ErrorPage(
                onTapped: () {
                  _fetchData();
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
