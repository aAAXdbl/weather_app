// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utils/weather_info_box.dart';
import 'package:weather_app/utils/weather_main_info_row.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("863def2fb0e26951383e06cce6199aa3");
  Weather? _weather;
  String? _countryName;
  bool isLoading = false;

  void _fetchWeather() async {
    isLoadingChange();
    String cityName = await _weatherService.getCurrentCity();
    String countryName = await _weatherService.getCurrentCountry();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _countryName = countryName;
      });
    } catch (e) {
      print(e);
    }
    isLoadingChange();
  }


  @override
  void initState() {
    super.initState();
    _fetchWeather();

  }

  void isLoadingChange() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> refreshScreen() async {
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.grey[800],
          // image: const DecorationImage(image: AssetImage("assets/linear.png")),
          gradient: const LinearGradient(
            colors: [Color(0xff062547), Color(0xff080928)],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            tileMode: TileMode.clamp,
          )),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              :  Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 40,
                            color: Colors.grey.shade300,
                          ),
                          Text(
                            "$_countryName, ${_weather?.name?.replaceAll("Province", "")} ",
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}, ${DateTime.now().year}",
                            style: GoogleFonts.roboto(
                                color: Colors.grey.shade300),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Image.asset(
                              _weatherService.getWeatherImage(
                                  _weather?.mainCondition),
                            ),
                          ),
                        ],
                      ),
                      MainInfoRow(weather: _weather),
                      WeatherInfoBox(weather: _weather)
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
