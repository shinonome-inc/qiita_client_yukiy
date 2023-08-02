import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/authenticated_user.dart';

import 'grey_article_part.dart';

class MyPageIntroduction extends StatelessWidget {
  const MyPageIntroduction(
      {Key? key,
      required this.authenticatedUser,
      required this.scrollController,
      required this.itemCount})
      : super(key: key);

  final AuthenticatedUser authenticatedUser;
  final ScrollController scrollController;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: myIntroduction(authenticatedUser, context),
    );
  }
}

Widget myIntroduction(
    AuthenticatedUser authenticatedUser, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: authenticatedUser.profileImageUrl,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              authenticatedUser.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                '@${authenticatedUser.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                authenticatedUser.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      GreyArticlePart(),
    ],
  );
}
