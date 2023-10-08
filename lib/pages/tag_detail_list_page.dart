import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/article_list_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../services/qiita_client.dart';
import '../ui_components/no_search_result.dart';
import 'error_page.dart';

class TagDetailListPage extends StatefulWidget {
  const TagDetailListPage({Key? key, required this.tagName}) : super(key: key);
  final String? tagName;

  @override
  State<TagDetailListPage> createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  List<Article> listTagDetail = [];
  Future<List<Article>>? futureTagDetails;
  late ScrollController _scrollController;
  late bool _isLoading = true;
  int pageNumber = 1;
  bool showError = false;
  bool isNetworkError = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchTagData();
    super.initState();
  }

  Future<void> _fetchTagData() async {
    List<Article> newTagDetail = [];
    setState(() {
      _isLoading = true;
      isNetworkError = false;
    });
    try {
      newTagDetail =
          await QiitaClient.fetchTagDetail(widget.tagName!, pageNumber);
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
      listTagDetail.addAll(newTagDetail);
      showError = newTagDetail.isEmpty ? true : false;
    });
    print('TagPageNumber is $pageNumber');
    print("TagFetched");
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
      await _fetchTagData();
    }
  }

  void _refresh() {
    setState(() {
      listTagDetail = [];
      pageNumber = 1;
    });
  }

  Future<void> _onRefresh() async {
    if (showError) {
      setState(() {
        showError = false;
      });
    }
    _refresh();
    _fetchTagData();
  }

  @override
  Widget build(BuildContext context) {
    return isNetworkError
        ? ErrorPage(
            onTapped: _onRefresh,
          )
        : Scaffold(
            appBar: UpperBar(
              appBarText: widget.tagName!,
              automaticallyImplyLeading: true,
            ),
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Center(
                child: showError
                    ? NoSearchResult()
                    : _isLoading && listTagDetail.isEmpty
                        ? const CupertinoActivityIndicator()
                        : ArticleListView(
                            articles: listTagDetail,
                            scrollController: _scrollController,
                            itemCount: _isLoading
                                ? listTagDetail.length + 1
                                : listTagDetail.length,
                          ),
              ),
            ),
          );
  }
}
