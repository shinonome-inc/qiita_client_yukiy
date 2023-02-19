import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

class QiitaClient {
  static Future<List<Article>> fetchArticle(String searchValue) async {
    String url = 'https://qiita.com/api/v2/items?query=title%3A$searchValue';
    print('get');
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
}
