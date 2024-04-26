import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[800],
        statusBarIconBrightness: Brightness.light,
      ))),
      debugShowCheckedModeBanner: false,
      home: const WeatherPage(),
    );
  }
}
