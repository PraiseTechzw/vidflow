import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeService {
  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';
  static const String _apiKey =
      'AIzaSyD7gHrbZF5agBvjlH0W4COTFUm3mYwFr7I'; // Replace with your API key

  Future<List<dynamic>> searchVideos(String query) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/search?part=snippet&type=video&q=$query&key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
