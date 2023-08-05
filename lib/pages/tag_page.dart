import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/tag.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/tag_grid_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

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
  late Future<List<Tag>> futureTags;
  late ScrollController _scrollController;
  bool? isLogin;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchTagData();
    Future.delayed(Duration.zero, () async {
      isLogin = await QiitaClient.switchPage();
      setState(() {}); // isLoginの値が更新されたことを反映するためにsetStateを呼び出す
    });
    super.initState();
  }

  Future<void> _fetchTagData() async {
    print('タグ数は $pageNumberです');
    print("タグ一覧取得");
    _isLoading = true;
    futureTag = QiitaClient.fetchTags(pageNumber);
    await Future.delayed(const Duration(seconds: 3));
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: UpperBar(
          showSearchBar: false,
          appBarText: 'Tags',
          textField: const TextField(),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: FutureBuilder<List<Tag>>(
            future: futureTag,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  _isLoading) {
                _isLoading = false;
                pageNumber += 1;
                listTags.addAll(snapshot.data ?? []);
                print('タグ件数: ${listTags.length}');
              }
              if (snapshot.hasData) {
                return TagGridView(
                  tagList: listTags,
                  itemCount: listTags.length,
                  scrollController: _scrollController,
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                );
              }
              print(snapshot.error);
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
