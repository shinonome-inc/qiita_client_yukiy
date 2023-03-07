import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/tag.dart';

class GreyArticlePart extends StatelessWidget implements PreferredSizeWidget {
  @override
  GreyArticlePart({Key? key, required FutureBuilder<List<Tag>> child})
      : super(key: key);
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: screenWidth,
              color: const Color(0xFFF2F2F2),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 28,
                child: const Text(
                  '投稿記事',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
