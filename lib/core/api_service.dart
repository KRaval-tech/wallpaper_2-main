
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://picsum.photos";

  // Fetch Featured Wallpapers with Lower Resolution
  Future<List<dynamic>> fetchFeaturedWallpapers({int page = 2, int limit = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl/v2/list?page=$page&limit=$limit"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((item) {
        return {
          ...item,
          "download_url": "$baseUrl/400/800?image=${item['id']}"
        };
      }).toList();
    } else {
      throw Exception("Failed to load featured wallpapers");
    }
  }

  // Fetch Suggested Wallpapers (Low Resolution)
  Future<List<dynamic>> fetchSuggestedWallpapers({int page = 3, int limit = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl/v2/list?page=$page&limit=$limit"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((item) {
        return {
          ...item,
          "download_url": "$baseUrl/400/700?image=${item['id']}"
        };
      }).toList();
    } else {
      throw Exception("Failed to load suggested wallpapers");
    }
  }
}
