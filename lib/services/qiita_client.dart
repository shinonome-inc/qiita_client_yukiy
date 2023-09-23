import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_client_yukiy/models/authenticated_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';
import '../models/tag.dart';

class QiitaClient {
  static final clientID = dotenv.env['CLIENTID'];
  static final clientSecret = dotenv.env['CLIENTSECRET'];

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

  //端末に保存
  static Future<void> saveAccessToken(String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", accessToken);
  }

  //端末から取ってくる
  static Future<String?> getAccessToken() async {
    var prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");
    return accessToken;
  }

  static Future<List<Article>> fetchArticle(
      String searchValue, int pageNumber) async {
    final accessToken = await getAccessToken();
    String url =
        'https://qiita.com/api/v2/items?page=$pageNumber&query=title%3A$searchValue';
    final response = await http.get(
      Uri.parse(url),
      headers: accessToken == null
          ? null
          : {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    );
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
    Uri uri;
    uri = Uri.parse('https://qiita.com');
    final String? state = uri.queryParameters["state"];
//認証
    String url =
        'https://qiita.com//api/v2/oauth/authorize?client_id=$clientID&scope=read_qiita+write_qiita&state=$state';
    return url;
  }

  static Future<AuthenticatedUser> fetchAuthenticatedUser() async {
    //認証済みユーザー
    final String? token = await getAccessToken();
    final keyAccessToken = "Bearer $token";
    final response = await http.get(
      Uri.parse('https://qiita.com/api/v2/authenticated_user'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: keyAccessToken,
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      return AuthenticatedUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<List<Article>> fetchAuthenticatedArticle(int pageNumber) async {
    String url =
        'https://qiita.com/api/v2/authenticated_user/items?page=$pageNumber&per_page=20';
    final String? token = await getAccessToken();

    final authorization = {"Authorization": "Bearer $token"};
    final response = await http.get(Uri.parse(url), headers: authorization);
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      final authenticatedArticleList =
          jsonArray.map((json) => Article.fromJson(json)).toList();
      return authenticatedArticleList;
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}${response.body}',
      );
    }
  }

  static Future<bool> switchPage() async {
    final token = await getAccessToken();
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<Map<String, String>> getAuthorizedHeaders() async {
    final token = await getAccessToken();
    if (token == null) {
      throw Exception('Access token is missing.');
    }
    return {
      HttpHeaders.authorizationHeader: "Bearer $token",
      'Content-Type': 'application/json',
    };
  }
}
