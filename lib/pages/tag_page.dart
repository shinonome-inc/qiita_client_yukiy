import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/tag.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/tag_grid_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../ui_components/no_search_result.dart';
import 'error_page.dart';

class TagPage extends StatefulWidget {
  const TagPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<Tag> listTags = [];
  int pageNumber = 1;
  late Future<List<Tag>> futureTag;
  late bool _isLoading = true;
  late ScrollController _scrollController;
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
    List<Tag> newTags = [];
    setState(() {
      _isLoading = true;
      isNetworkError = false;
    });
    try {
      newTags = await QiitaClient.fetchTags(pageNumber);
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
      listTags.addAll(newTags);
      showError = newTags.isEmpty ? true : false;
    });
    print('タグ数は $pageNumber です');
    print("タグ一覧取得");
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
      listTags = [];
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
            backgroundColor: Colors.white,
            appBar: const UpperBar(
              showSearchBar: false,
              appBarText: 'Tags',
              textField: TextField(),
              automaticallyImplyLeading: false,
            ),
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Center(
                child: _isLoading && listTags.isEmpty
                        ? const CupertinoActivityIndicator()
                        : TagGridView(
                            tagList: listTags,
                            itemCount: listTags.length,
                            scrollController: _scrollController,
                          ),
              ),
            ),
          );
  }
}
