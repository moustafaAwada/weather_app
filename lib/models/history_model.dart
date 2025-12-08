class HistoryModel {
  final String cityName;
  final double temp;
  final String condition;
  final String icon; 
  final DateTime searchTime;

  HistoryModel({
    required this.cityName,
    required this.temp,
    required this.condition,
    required this.icon,
    required this.searchTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'city_name': cityName,
      'temp': temp,
      'condition': condition,
      'icon': icon,
      'search_time': searchTime.toIso8601String(),
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      cityName: json['city_name'], 
      temp: json['temp'].toDouble(),
      condition: json['condition'],
      icon: json['icon'],
      searchTime: DateTime.parse(json['search_time']), 
    );
  }
}