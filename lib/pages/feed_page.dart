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
  late ScrollController _scrollController;
  late bool _isLoading = true;
  int pageNumber = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchData();
    super.initState();
    print("ajja");
  }

  Future<void> _fetchData() async {
    futureArticles = QiitaClient.fetchArticle("", pageNumber);
    _isLoading = false;
    listArticle.addAll(await futureArticles);

    setState(
      () {
        pageNumber++;
        print('pageNumber is $pageNumber');
      },
    );
  }

  void _scrollListener() async {
    double positionRate =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
    print(positionRate);
    const double threshold = 0.9;
    if (positionRate > threshold && !_isLoading) {
      setState(() {
        _isLoading = true;
        print("isLoadingtrue");
      });
      await _fetchData();
      print("fetched");
    }
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
                futureArticles = QiitaClient.fetchArticle(value, 1);
              });
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
              listArticle = listArticle + snapshot.data!;
              return ArticleListView(
                articles: listArticle,
                scrollController: _scrollController,
                itemCount:
                    _isLoading ? listArticle.length + 1 : listArticle.length,
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
        ),
      ),
    );
  }
}
