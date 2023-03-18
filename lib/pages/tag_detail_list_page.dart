import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/article_list_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../services/qiita_client.dart';

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

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchTagData();
    super.initState();
  }

  Future<void> _fetchTagData() async {
    print('TagPageNumber is $pageNumber');
    print("TagFetched");
    _isLoading = true;
    futureTagDetails = QiitaClient.fetchTagDetail(widget.tagName!, pageNumber);
    await Future.delayed(const Duration(seconds: 1));
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
      await _fetchTagData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperBar(
        appBarText: widget.tagName!,
        textField: const TextField(),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: futureTagDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                _isLoading) {
              _isLoading = false;
              pageNumber += 1;
              listTagDetail.addAll(snapshot.data!);
              print('タグ表示件数: ${listTagDetail.length}');
            }
            if (snapshot.hasData) {
              return ArticleListView(
                  articles: listTagDetail,
                  scrollController: _scrollController,
                  itemCount: _isLoading
                      ? listTagDetail.length + 1
                      : listTagDetail.length,
                  showGreyPart: true);
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
