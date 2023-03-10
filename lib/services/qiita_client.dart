import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../models/tag.dart';

class QiitaClient {
  static Future<List<Article>> fetchArticle(
      String searchValue, int pageNumber) async {
    String url =
        'https://qiita.com/api/v2/items?page=$pageNumber&query=title%3A$searchValue';
    final authorization = {
      "Authorization": "Bearer defd822a3e7702cac78d66eefe2ed5c8d174e202"
    };
    final response = await http.get(Uri.parse(url), headers: authorization);
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final articleList =
          jsonArray.map((json) => Article.fromJson(json)).toList();
      return articleList;
    } else {
      throw Exception(
          'Request failed with status: ${response.statusCode}${response.body}');
    }
  }

  static Future<List<Tag>> fetchTags(int pageNumber) async {
    //タグ一覧
    String url =
        'https://qiita.com/api/v2/tags?page=$pageNumber&per_page=20&sort=count';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final tagList = jsonArray.map((json) => Tag.fromJson(json)).toList();
      return tagList;
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}${response.body}',
      );
    }
  }

  static Future<List<Article>> fetchTagDetail(
      String tagName, int pageNumber) async {
    //タグ詳細
    String url =
        'https://qiita.com//api/v2/tags/$tagName/items?page=$pageNumber&page=1&per_page=20';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final tagDetailList =
          jsonArray.map((json) => Article.fromJson(json)).toList();
      return tagDetailList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
