import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../models/tag.dart';

class QiitaClient {
  static final clientID = dotenv.env['CLIENTID'];
  static final clientSecret = dotenv.env['CLIENTSECRET'];
  static final keyAccessToken = dotenv.env['QIITA_ACCESS_TOKEN'];

  static String createAuthorizeUrl() {
    const scope = 'read_qiita%20write_qiita';
    String url =
        'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope';
    return url;
  }

  static Future<String> fetchAccessToken(String code) async {
    final response = await http.post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(
        {
          'client_id': clientID,
          'client_secret': clientSecret,
          'code': code,
        },
      ),
    );
    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final accessToken = body['token'];
      return accessToken;
    } else {
      throw Exception('Request failed with status:${response.statusCode}');
    }
  }

  static Future<List<Article>> fetchArticle(
      String searchValue, int pageNumber) async {
    String url =
        'https://qiita.com/api/v2/items?page=$pageNumber&query=title%3A$searchValue';
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    final authorization = {"Authorization": "Bearer $token"};
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
        'https://qiita.com//api/v2/tags/$tagName/items?page=$pageNumber&per_page=20';
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

  static String fetchLogin() {
//認証
    String url =
        'https://qiita.com//api/v2/oauth/authorize?client_id=67b56264308408ab81df90f81184e680ffa26d48&scope=read_qiita+write_qiita&state=bb17785d811bb1913ef54b0a7657de780defaa2d HTTP/1.1';
    return url;
  }
}
