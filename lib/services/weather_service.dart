import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '8e853d078fef4205a5f190204252206';
  WeatherService(this.dio);

  Future<WeatherModel> getCurrentWeahter({required String cityName}) async {
    try {
      Response respons = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=14',
      );
      WeatherModel weatherModel = WeatherModel.fromJson(respons.data);
      return weatherModel;
    } on DioException catch (e) {
      final String messageError =
          e.response?.data['error']['message'] ??
          'oops there was an error, please try later';
      throw (messageError);
    } on Exception catch (e) {
      throw Exception('oops there was an error, please try later ');
    }
  }
}
