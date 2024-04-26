import 'dart:convert';
import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5";
  final String apiKey; //= "863def2fb0e26951383e06cce6199aa3";

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
        Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == HttpStatus.ok) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("HTTP GET FAILED! Status Code => ${response.statusCode}");
    }
  }

  Future<List<Weather>> getWeatherWeek(String cityName) async {
    final response = await http.get(
        Uri.parse('$baseUrl/forecast?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<Weather> list =
          json['list'].map<Weather>((e) => Weather.fromJson(e)).toList();
      print(list);
      return list;
    } else {
      throw Exception("HTTP GET FAILED! Status Code => ${response.statusCode}");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = "${placemarks[0].administrativeArea}";

    return city;
  }

  Future<String> getCurrentCountry() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? country = "${placemarks[0].country}";

    return country;
  }

  String getWeatherImage(String? mainCondition) {
    if (mainCondition == null) {
      return "assets/6.png";
    }
    switch (mainCondition.toLowerCase()) {
      case "clouds":
        return "assets/clouds.png";
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/particle_clouds.png";
      case "rain":
      case "drizzle":
        return "assets/rainy.png";
      case "shower rain":
        return "assets/rainyfall.png";
      case "thunderstorm":
        return "assets/thunder.png";
      case "clear":
        return "assets/sunny.png";
      default:
        return "assets/sunny.png";
    }
  }
}
