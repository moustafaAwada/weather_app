import '../../models/weather_model.dart';


class WeatherState {}

class InitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
}

class WeatherFailureState extends WeatherState {}

class WeatherLoadedByUserCityState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedByUserCityState({required this.weatherModel});
}
