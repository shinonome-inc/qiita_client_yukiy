import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/authenticated_user.dart';

import 'grey_article_part.dart';

class MyPageIntroduction extends StatelessWidget {
  const MyPageIntroduction({Key? key, required this.authenticatedUser})
      : super(key: key);

  final AuthenticatedUser? authenticatedUser;

  @override
  Widget build(BuildContext context) {
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
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: authenticatedUser!.profileImageUrl,
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                authenticatedUser!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  '@${authenticatedUser!.id}',
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
                  authenticatedUser!.description,
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
}
