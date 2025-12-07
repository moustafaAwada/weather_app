import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  // ⚠️ ANDROID EMULATOR: Use 'http://10.0.2.2:8000'
  // ⚠️ iOS SIMULATOR: Use 'http://127.0.0.1:8000'
  // ⚠️ REAL DEVICE: Use your PC's IP address (e.g., 'http://192.168.1.5:8000')
  final String baseUrl = kIsWeb 
        ? 'https://aqsar.yllabena.com/api/v1'  // For Web Browser
        : 'https://aqsar.yllabena.com/api/v1';  // For Android Emulator
  // --- LOGIN ---
  Future<UserModel> login({required String email, required String password}) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/login/',
        data: {
          'email': email,
          'password': password,
        },
      );

      // ✅ 1. Get the token from response
      // (Make sure your Django returns 'access' or 'token')
      String token = response.data['access']; 

      // ✅ 2. Save token to phone storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // 3. Return User
      return UserModel.fromJson(response.data['user']); 
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw "An unknown error occurred";
    }
  }

  // --- REGISTER ---
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/register/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone ?? "", 
        },
      );

      // Assuming API returns the created user object or same structure as login
      // If your register endpoint logs them in automatically:
      if (response.data['user'] != null) {
         return UserModel.fromJson(response.data['user']);
      } else {
         // If it just returns "Success", you might need to login immediately or return a dummy
         return UserModel(name: name, email: email, password: password, phone: phone);
      }

    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw "An unknown error occurred";
    }
  }

  // --- ERROR HANDLING ---
  String _handleError(DioException e) {
    if (e.response != null) {
      // Server returned an error (400, 401, 500)
      if (e.response!.data != null && e.response!.data['error'] != null) {
        return e.response!.data['error']; // Custom message from Django
      }
      return "Server error: ${e.response!.statusCode}";
    } else {
      // Connection error (Server down, wrong IP)
      return "Connection failed. Check your internet or server URL.";
    }
  }
}