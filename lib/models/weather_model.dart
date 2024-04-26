class Weather {
  final String? name;
  final double? temperature;
  final double? tempMin;
  final double? tempMax;
  final double? feelLike;
  final double? pressure;
  final double? humidity;
  final double? windSpeed;
  final String? mainCondition;
  final String? subCondition;

  Weather({
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.name,
    required this.temperature,
    required this.feelLike,
    required this.mainCondition,
    required this.subCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      subCondition: json['weather'][0]['description'],
    );
  }
}
