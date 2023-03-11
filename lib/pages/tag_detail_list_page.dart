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
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchTagData();
    super.initState();
  }

  Future<void> _fetchTagData() async {
    _isLoading = true;
    futureTagDetails = QiitaClient.fetchTagDetail(widget.tagName!, pageNumber);
    await Future.delayed(const Duration(seconds: 1));
    listTagDetail.addAll(await futureTagDetails!);
    print("TagFetched");
    print('TagPageNumber is $pageNumber');
    print('タグ表示件数: ${listTagDetail.length}');

    if (mounted) {
      setState(
        () {
          if (listTagDetail.isNotEmpty) {
            pageNumber++;
          }
        },
      );
    }
  }

  void _scrollListener() async {
    double positionRate =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
    const double threshold = 0.8;
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

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
            if (snapshot.hasData) {
              listTagDetail = snapshot.data!;
              return ListView(
                children: [
                  SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: ArticleListView(
                      articles: listTagDetail,
                      scrollController: _scrollController,
                      itemCount: _isLoading
                          ? listTagDetail.length + 1
                          : listTagDetail.length,
                    ),
                  ),
                ],
              );
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
