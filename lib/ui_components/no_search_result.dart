import 'package:flutter/material.dart';

class NoSearchResult extends StatelessWidget {
  NoSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3.5),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "検索にマッチする記事はありませんでした",
            style: TextStyle(fontSize: 14, color: Colors.black),
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
    );
  }
}
