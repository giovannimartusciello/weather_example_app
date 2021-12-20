import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gm_weather_app/models/weather.dart';
import 'package:gm_weather_app/utils/temperature_convert.dart';
import 'package:weather_icons/weather_icons.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  const DailySummaryView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(weather.date));

    return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
              Text(
                  "Min :${TemperatureConvert.kelvinToCelsius(weather.minTemp).round().toString()}° Max :${TemperatureConvert.kelvinToCelsius(weather.maxTemp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
              Text(weather.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToImage(weather.condition)))
          ],
        ));
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    IconData image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = WeatherIcons.thunderstorm;
        break;
      case WeatherCondition.heavyCloud:
        image = WeatherIcons.cloudy_gusts;
        break;
      case WeatherCondition.lightCloud:
        image = WeatherIcons.cloudy;
        break;
      case WeatherCondition.drizzle:
        image = WeatherIcons.raindrop;
        break;
      case WeatherCondition.mist:
        image = WeatherIcons.fog;
        break;
      case WeatherCondition.clear:
        image = WeatherIcons.day_sunny;
        break;
      case WeatherCondition.fog:
        image = WeatherIcons.fog;
        break;
      case WeatherCondition.snow:
        image = WeatherIcons.snow;
        break;
      case WeatherCondition.rain:
        image = WeatherIcons.rain;
        break;

      default:
        image = WeatherIcons.na;
    }

    return Padding(
        padding: const EdgeInsets.only(top: 5), child: BoxedIcon(image));
  }
}
