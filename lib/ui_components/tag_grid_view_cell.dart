import 'package:flutter/material.dart';

import '../models/tag.dart';

class TagGridViewCell extends StatelessWidget {
  const TagGridViewCell({Key? key, required this.tag}) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
      ),
      child: Column(
        children: [
          Flexible(
            child: Center(
              child: Image.network(
                tag.iconUrl.toString(),
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tag.id!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Text(
                  "記事件数: ${tag.itemsCount}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF828282),
                  ),
                ),
                Text(
                  "フォロワー数: ${tag.followersCount}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF828282),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
