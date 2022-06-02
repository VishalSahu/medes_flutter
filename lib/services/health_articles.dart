import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medes/model/article_model.dart';

Future<List<HealthApiModel>> getArticles() async {
  Uri uri = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=6ee0a18a863f40b2b3448fbf923821d6');
  final response = await http.get(uri);
  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = jsonDecode(response.body);
    List _articlesList = map['articles'];
    List<HealthApiModel> newsList = _articlesList
        .map((jsonData) => HealthApiModel.fromJson(jsonData))
        .toList();
    return newsList;
  } else {
    return [];
  }
}
