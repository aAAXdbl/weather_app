import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widget/gradient_text.dart';

class WeatherInfoBox extends StatefulWidget {
  const WeatherInfoBox({
    super.key,
    required Weather? weather,
  }) : _weather = weather;

  final Weather? _weather;

  @override
  State<WeatherInfoBox> createState() => _WeatherInfoBoxState();
}

class _WeatherInfoBoxState extends State<WeatherInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff5B89D7),
              Color(0xff324AA4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        width: double.infinity,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InfoTextRow(
              firstText: "Min. Temp",
              secondText: "Feel Like",
              thirdText: "Max. Temp",
            ),
            InfoRow(
              firstInfo: "${widget._weather?.tempMin}°C",
              secondInfo: "${widget._weather?.feelLike}°C",
              thirdInfo: "${widget._weather?.tempMax}°C",
            ),
            const InfoTextRow(
              firstText: "Pressure",
              secondText: "Winds",
              thirdText: "Humidity",  
            ),
            InfoRow(
              firstInfo: "${widget._weather?.pressure}",
              secondInfo: "${widget._weather?.windSpeed}km/h",
              thirdInfo: "${widget._weather?.humidity?.round()}%",
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.firstInfo,
    required this.secondInfo,
    required this.thirdInfo,
  });

  final String firstInfo, secondInfo, thirdInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          firstInfo,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          secondInfo,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          thirdInfo,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class InfoTextRow extends StatelessWidget {
  const InfoTextRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
  }) : super(key: key);

  final String firstText, secondText, thirdText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GradientText(firstText,
            gradient:
                const LinearGradient(colors: [Colors.orange, Colors.pink]),
            style: GoogleFonts.roboto()),
        const SizedBox(width: 10),
        GradientText(secondText,
            gradient:
                const LinearGradient(colors: [Colors.orange, Colors.pink]),
            style: GoogleFonts.roboto()),
        const SizedBox(width: 10),
        GradientText(thirdText,
            gradient:
                const LinearGradient(colors: [Colors.orange, Colors.pink]),
            style: GoogleFonts.roboto()),
      ],
    );
  }
}