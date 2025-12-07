import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';

  final String apiKey = '8e853d078fef4205a5f190204252206';

  WeatherService(this.dio);

  Future<WeatherModel> getCurrentWeahter({required String cityName}) async {
    try {
      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7', 
      );
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String messageError = e.response?.data['error']['message'] ??
          'oops there was an error, please try later';
      throw (messageError);
    } catch (e) {
      throw Exception('oops there was an error, please try later');
    }
  }

  Future<List<dynamic>> getCitySuggestions(String query) async {
    // CHANGE THIS LINE: Only return empty if query is actually empty
    if (query.isEmpty) return []; 
    
    try {
      Response response = await dio.get(
        '$baseUrl/search.json?key=$apiKey&q=$query',
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }
}