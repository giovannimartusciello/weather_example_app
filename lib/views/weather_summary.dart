import 'package:flutter/material.dart';
import 'package:gm_weather_app/models/weather.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String humidity;
  final bool isdayTime;

  const WeatherSummary(
      {Key? key,
      required this.condition,
      required this.temp,
      required this.minTemp,
      required this.maxTemp,
      required this.humidity,
      required this.isdayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(temp)}°ᶜ',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Min: ${_formatTemperature(minTemp)}°ᶜ Max: ${_formatTemperature(maxTemp)}°ᶜ',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Humidity $humidity°%',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = t.round().toString();
    return temp;
  }
}
