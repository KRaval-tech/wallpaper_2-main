// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const String baseUrl = "https://picsum.photos/v2/list?page=1&limit=10";
//       //https://your-api-endpoint.com"; // Replace with your API endpoint
//
//   Future<List<dynamic>> fetchFeaturedWallpapers() async {
//     final response = await http.get(Uri.parse(baseUrl/*"$baseUrl/featured-wallpapers"*/));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to load featured wallpapers");
//     }
//   }
//
//   Future<List<dynamic>> fetchSuggestedWallpapers() async {
//     final response = await http.get(Uri.parse(baseUrl/*"$baseUrl/suggested-wallpapers"*/));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to load suggested wallpapers");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://picsum.photos/v2/list"; // Picsum API

  // Fetch Featured Wallpapers (e.g., first 10 images)
  Future<List<dynamic>> fetchFeaturedWallpapers({int page = 4, int limit = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page&limit=$limit"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load featured wallpapers");
    }
  }

  // Fetch Suggested Wallpapers (e.g., different page for variety)
  Future<List<dynamic>> fetchSuggestedWallpapers({int page = 5, int limit = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page&limit=$limit"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load suggested wallpapers");
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const String baseUrl = "https://picsum.photos/v2/list"; // Picsum API
//
//   // Fetch all wallpapers with pagination
//   Future<List<dynamic>> fetchWallpapers({int page = 1}) async {
//     final response = await http.get(Uri.parse("$baseUrl?page=$page"));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to load wallpapers");
//     }
//   }
//
//   // Fetch Featured Wallpapers (first page)
//   Future<List<dynamic>> fetchFeaturedWallpapers() async {
//     return fetchWallpapers(page: 2);
//   }
//
//   // Fetch Suggested Wallpapers (different page for variety)
//   Future<List<dynamic>> fetchSuggestedWallpapers() async {
//     return fetchWallpapers(page: 3);
//   }
//
//   // Fetch Latest Wallpapers (third page)
//   Future<List<dynamic>> fetchLatestWallpapers() async {
//     return fetchWallpapers(page: 4);
//   }
//
//   // Fetch Random Wallpapers (fourth page)
//   Future<List<dynamic>> fetchRandomWallpapers() async {
//     return fetchWallpapers(page: 5);
//   }
// }
