import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widget/gradient_text.dart';

class MainInfoRow extends StatelessWidget {
  const MainInfoRow({
    super.key,
    required Weather? weather,
  }) : _weather = weather;

  final Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GradientText(
          '${_weather?.temperature?.round()}°',
          style: robotoText(75),
          gradient: customLinearGradient(),
        ),
        Column(
          children: [
            GradientText(
              _weather?.mainCondition ?? "",
              style: robotoText(20),
              gradient: customLinearGradient(),
            ),
            GradientText(
              _weather?.subCondition ?? "",
              style: robotoText(20),
              gradient: customLinearGradient(),
            ),
          ],
        ),
      ],
    );
  }

  LinearGradient customLinearGradient() {
    return const LinearGradient(colors: [
      Colors.blue,
      Colors.white,
    ], stops: [
      0.1,
      0.9
    ]);
  }

  TextStyle robotoText(double fontSize) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
