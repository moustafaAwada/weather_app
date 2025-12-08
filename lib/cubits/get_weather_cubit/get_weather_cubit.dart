import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/history_service.dart'; // 1. Import History Service

class GetweatherCubit extends Cubit<WeatherState> {
  GetweatherCubit() : super(InitialState());
  
  WeatherModel? weatherModel;

  final WeatherService weatherService = WeatherService(Dio());

  Future<void> getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      weatherModel = await weatherService.getCurrentWeahter(cityName: cityName);

      if (weatherModel != null) {
        HistoryService().addToHistory(weatherModel!);
      }

      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailureState());
    }
  }

  Future<void> getWeatherByUserCity(String city) async {
    emit(WeatherLoadingState());
    try {
      final weather = await weatherService.getCurrentWeahter(cityName: city);
      weatherModel = weather;
      emit(WeatherLoadedByUserCityState(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
