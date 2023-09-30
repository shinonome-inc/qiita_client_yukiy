import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/authenticated_user.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

import '../models/article.dart';
import '../services/qiita_client.dart';
import '../ui_components/article_list_view.dart';
import '../ui_components/my_page_introduction.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Article> listArticle = [];
  AuthenticatedUser? authenticatedUser;
  Future<AuthenticatedUser>? futureAuthentication;
  int pageNumber = 1;
  late ScrollController _scrollController;
  bool _isLoading = true;
  bool isNetworkError = false;
  TextEditingController _editController = TextEditingController();
  bool showError = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    List<Article> newArticle = [];
    futureAuthentication = QiitaClient.fetchAuthenticatedUser();
    authenticatedUser = await futureAuthentication;
    setState(() {
      _isLoading = true;
      isNetworkError = false;
    });
    try {
      newArticle = await QiitaClient.fetchAuthenticatedArticle(pageNumber);
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
      showError = newArticle.isEmpty ? true : false;
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
    if (showError) {
      setState(() {
        _editController = TextEditingController();
        showError = false;
      });
    }
    _refresh();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const UpperBar(
          appBarText: 'MyPage',
          textField: TextField(),
          automaticallyImplyLeading: false,
        ),
        body: _isLoading && listArticle.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  MyPageIntroduction(authenticatedUser: authenticatedUser),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ArticleListView(
                        articles: listArticle,
                        scrollController: _scrollController,
                        itemCount: _isLoading
                            ? listArticle.length + 1
                            : listArticle.length,
                        showImage: false,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
