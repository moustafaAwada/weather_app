

class WeatherState {}

class InitialState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherLoadedState();
}

class WeatherFailurState extends WeatherState {}
