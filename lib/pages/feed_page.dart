import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/pages/error_page.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/article_list_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../ui_components/no_search_result.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Article> listArticle = [];
  late ScrollController _scrollController;
  bool _isLoading = true;
  int pageNumber = 1;
  TextEditingController _editController = TextEditingController();
  bool showNoSearchResult = false;
  bool isNetworkError = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    List<Article> newArticle = [];
    setState(() {
      _isLoading = true;
      isNetworkError = false;
    });
    try {
      newArticle =
          await QiitaClient.fetchArticle(_editController.text, pageNumber);
    } catch (e) {
      setState(() {
        isNetworkError = true;
      });
      throw Exception(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      listArticle.addAll(newArticle);
      showNoSearchResult = newArticle.isEmpty ? true : false;
    });

    print("fetched");
    print('pageNumber is $pageNumber');
    print('表示件数: ${listArticle.length}');
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
      pageNumber++;
      await _fetchData();
    }
  }

  void _refresh() {
    setState(() {
      listArticle = [];
      pageNumber = 1;
    });
  }

  Future<void> _onRefresh() async {
    if (showNoSearchResult) {
      setState(() {
        _editController = TextEditingController();
        showNoSearchResult = false;
      });
    }
    _refresh();
    _fetchData();
  }

  Future<void> _searchResult() async {
    _refresh();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isNetworkError
        ? ErrorPage(
            onTapped: _onRefresh,
          )
        : Scaffold(
            appBar: UpperBar(
              showSearchBar: true,
              appBarText: 'Feed',
              textField: TextField(
                controller: _editController,
                onSubmitted: (value) {
                  _searchResult();
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      _editController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  suffixIconColor: Colors.grey,
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
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Center(
                child: showNoSearchResult
                    ? NoSearchResult()
                    : _isLoading && listArticle.isEmpty
                        ? const CupertinoActivityIndicator()
                        : ArticleListView(
                            articles: listArticle,
                            scrollController: _scrollController,
                            itemCount: _isLoading
                                ? listArticle.length + 1
                                : listArticle.length,
                          ),
              ),
            ),
          );
  }
}
