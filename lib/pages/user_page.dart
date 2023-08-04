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
  Future<List<Article>>? futureArticles;
  Future<AuthenticatedUser>? futureAuthentication;
  int pageNumber = 1;
  late ScrollController _scrollController;
  late bool _isLoading = true;

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
    futureAuthentication = QiitaClient.fetchAuthenticatedUser();
    authenticatedUser = await futureAuthentication;

    if (authenticatedUser == null) {
      return;
    }
    _isLoading = false;
    futureArticles = QiitaClient.fetchAuthenticatedArticle(pageNumber);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: UpperBar(
          appBarText: 'MyPage',
          textField: const TextField(),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<AuthenticatedUser>(
              future: futureAuthentication,
              builder: (BuildContext context,
                  AsyncSnapshot<AuthenticatedUser> snapshot) {
                if (snapshot.hasData) {
                  return myIntroduction(snapshot.data!, context);
                } else if (snapshot.hasError) {
                  return const Text("受け取れていません");
                }
                return const SizedBox(
                  height: 223,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: futureArticles,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("Error is: ${snapshot.error}");
                    return const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    );
                  } else if (snapshot.hasData) {
                    if (listArticle.isEmpty) {
                      return const Center(child: Text("記事がありません"));
                    } else {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          print("👀 ${constraints.minHeight}");
                          print("👀 ${constraints.maxHeight}");
                          return SizedBox(
                            height: constraints.minHeight,
                            child: ArticleListView(
                              articles: listArticle,
                              scrollController: _scrollController,
                              itemCount: _isLoading
                                  ? listArticle.length + 1
                                  : listArticle.length,
                              showImage: false,
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
