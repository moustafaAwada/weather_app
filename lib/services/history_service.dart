import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import '../models/history_model.dart';
import '../models/weather_model.dart';

class HistoryService {
  final Dio _dio = Dio();
  
  // Same Base URL logic
  final String baseUrl = kIsWeb 
      ? 'https://aqsar.yllabena.com/api/v1' 
      : 'https://aqsar.yllabena.com/api/v1';

  // 1. Add to History (POST)
  Future<void> addToHistory(WeatherModel weather) async {
    try {
      // Get the token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) return; // Not logged in

      // Create model
      final newItem = HistoryModel(
        cityName: weather.cityName,
        temp: weather.temp,
        condition: weather.weahterCondition,
        icon: weather.image ?? "",
        searchTime: DateTime.now(),
      );

      // Send to Django
      await _dio.post(
        '$baseUrl/history/',
        data: newItem.toJson(), // Sends snake_case keys
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Attach Token
          },
        ),
      );
    } catch (e) {
      print("Error saving history: $e");
    }
  }

  // 2. Get History (GET)
  Future<List<HistoryModel>> getHistory() async {
    try {
      // Get the token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) return [];

      Response response = await _dio.get(
        '$baseUrl/history/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Attach Token
          },
        ),
      );

      // Parse list
      List<dynamic> data = response.data;
      return data.map((json) => HistoryModel.fromJson(json)).toList();
      
    } catch (e) {
      print("Error fetching history: $e");
      return [];
    }
  }
}