


class WeatherState {}

class InitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
}

class WeatherFailureState extends WeatherState {}