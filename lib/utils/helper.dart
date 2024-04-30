import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:moviesapp/data/model/result_adapter.dart';

class ApiCacheHelper {
  static Dio dio = Dio();
  static int _cacheTimeout = Duration(hours: 1).inMilliseconds; // 1 hour
  static const String _baseUrl = "https://api.themoviedb.org/3/trending/movie/";

  static Future<Map<String, dynamic>?> getJsonResponse(String endpoint) async {
    final box = Hive.box<ApiResponse>('apiResponses');
    final cachedResponse =
        box.get(endpoint); // Use endpoint as key for specificity

    if (cachedResponse != null &&
        DateTime.now().millisecondsSinceEpoch - cachedResponse.timestamp <
            _cacheTimeout) {
      return json.decode(cachedResponse.response);
    }

    try {
      final response = await dio.get('$_baseUrl/$endpoint');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.data) as Map<String, dynamic>;
        final newResponse = ApiResponse(
          url: endpoint,
          response: json.encode(jsonResponse),
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );
        await box.put(endpoint, newResponse); // Use endpoint as key
        return jsonResponse;
      } else {
        print('Error fetching data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }

  static Future<void> putJsonResponse(
      String endpoint, Map<String, dynamic> data) async {
    final box = Hive.box<ApiResponse>('apiResponses');
    final newResponse = ApiResponse(
      url: endpoint,
      response: json.encode(data),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await box.put(endpoint, newResponse);
  }
}
