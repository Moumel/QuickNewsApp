import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/article.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  final String apiKey;

  ApiService({required this.apiKey});

  Future<List<Article>> fetchTopHeadlines(String category, {String query = ''}) async {
    final uri = Uri.parse(
      '$_baseUrl/top-headlines?country=us&category=$category&q=$query&apiKey=$apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final articles = data['articles'] as List;
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}