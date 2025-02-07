import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://picsum.photos/v2/list?page=1&limit=10";
      //https://your-api-endpoint.com"; // Replace with your API endpoint

  Future<List<dynamic>> fetchFeaturedWallpapers() async {
    final response = await http.get(Uri.parse(baseUrl/*"$baseUrl/featured-wallpapers"*/));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load featured wallpapers");
    }
  }

  Future<List<dynamic>> fetchSuggestedWallpapers() async {
    final response = await http.get(Uri.parse(baseUrl/*"$baseUrl/suggested-wallpapers"*/));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load suggested wallpapers");
    }
  }
}
