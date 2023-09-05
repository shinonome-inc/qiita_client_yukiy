import 'package:flutter/material.dart';
// ignore: must_be_immutable
class NoSearchResult extends StatelessWidget {
  NoSearchResult({Key? key}) : super(key: key);
  late double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: screenHeight / 3.5),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "検索にマッチする記事はありませんでした",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 17),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '検索条件を変えるなどして再度検索をしてください',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
