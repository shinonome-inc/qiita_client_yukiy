import 'package:qiita_client_yukiy/models/user.dart';

class Article {
  final String title;
  final String url;
  final User user;
  final String dateTime;

  Article(
      {required this.title,
      required this.url,
      required this.user,
      required this.dateTime});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      user: User.fromJson(json['user']),
      dateTime: json['created_at'],
    );
  }
}
