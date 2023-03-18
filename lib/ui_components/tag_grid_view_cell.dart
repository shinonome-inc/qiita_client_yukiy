import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/tag.dart';
import '../pages/tag_detail_list_page.dart';

class TagGridViewCell extends StatelessWidget {
  TagGridViewCell({Key? key, required this.tag}) : super(key: key);

  final Tag tag;
  static String defaultIconImage =
      "https://cdn.qiita.com/assets/public/icon-missing_tag-63d8678a29c9158bc7ccea1c4c8e7114.png";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TagDetailListPage(tagName: tag.id)),
        );
      },
      child: Container(
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
                child: CachedNetworkImage(
                  imageUrl: tag.iconUrl.toString(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/icon-missing_tag.png',
                  ),
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
      ),
    );
  }
}
