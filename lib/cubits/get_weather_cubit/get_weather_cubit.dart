import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/history_service.dart'; // 1. Import History Service

class GetweatherCubit extends Cubit<WeatherState> {
  GetweatherCubit() : super(InitialState());
  
  WeatherModel? weatherModel;

  getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      // 1. Get Weather from API
      weatherModel = await WeatherService(Dio()).getCurrentWeahter(cityName: cityName);
      
      // 2. Save to Django Database (Background process)
      if (weatherModel != null) {
        // We don't await this, so it doesn't slow down the UI
        HistoryService().addToHistory(weatherModel!);
      }

      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}