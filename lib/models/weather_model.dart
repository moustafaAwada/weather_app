class WeatherModel {
  final String cityName;
  final DateTime date;
  final String? image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weahterCondition;
  
  // New Lists
  final List<DayWeather> dailyForecast;
  final List<HourWeather> hourlyForecast;

  WeatherModel({
    required this.cityName,
    required this.date,
    this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weahterCondition,
    required this.dailyForecast,
    required this.hourlyForecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // 1. Parse Daily Forecast (Next 3-5 days depending on API plan)
    List<DayWeather> days = [];
    if (json['forecast']['forecastday'] != null) {
      json['forecast']['forecastday'].forEach((element) {
        days.add(DayWeather.fromJson(element));
      });
    }

    // 2. Parse Hourly Forecast (from the first day, usually index 0)
    List<HourWeather> hours = [];
    if (json['forecast']['forecastday'][0]['hour'] != null) {
      json['forecast']['forecastday'][0]['hour'].forEach((element) {
        hours.add(HourWeather.fromJson(element));
      });
    }

    return WeatherModel(
      cityName: json["location"]["name"],
      date: DateTime.parse(json['current']['last_updated']),
      // Use the icon from the current condition
      image: json['current']['condition']['icon'],
      temp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      weahterCondition: json['forecast']['forecastday'][0]['day']['condition']['text'],
      dailyForecast: days,
      hourlyForecast: hours,
    );
  }
}

// --- Helper Classes ---

class DayWeather {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  DayWeather({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      date: DateTime.parse(json['date']),
      maxTemp: json['day']['maxtemp_c'],
      minTemp: json['day']['mintemp_c'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
    );
  }
}

class HourWeather {
  final DateTime time;
  final double temp;
  final String icon;

  HourWeather({
    required this.time,
    required this.temp,
    required this.icon,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) {
    return HourWeather(
      // The API usually returns "2023-10-25 10:00" string
      time: DateTime.parse(json['time']),
      temp: json['temp_c'],
      icon: json['condition']['icon'],
    );
  }
}