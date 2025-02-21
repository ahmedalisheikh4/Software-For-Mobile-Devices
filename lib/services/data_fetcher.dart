import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_data.dart';

class DataFetcher {
  static const String apiEndpoint = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<ArticleData>> getArticles() async {
    try {
      final response = await http.get(Uri.parse(apiEndpoint));
      
      if (response.statusCode == 200) {
        final List<dynamic> rawData = json.decode(response.body);
        return rawData.map((data) => ArticleData.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}
