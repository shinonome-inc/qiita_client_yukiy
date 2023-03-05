import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

class QiitaClient {
  static Future<List<Article>> fetchArticle(String searchValue) async {
    String url = 'https://qiita.com/api/v2/items?query=title%3A$searchValue';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final articleList =
          jsonArray.map((json) => Article.fromJson(json)).toList();
      return articleList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<List<Article>> fetchTag(String tagName) async {
    String url =
        'https://qiita.com//api/v2/tags/$tagName/items?page=1&per_page=20';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final tagList = jsonArray.map((json) => Article.fromJson(json)).toList();
      return tagList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
