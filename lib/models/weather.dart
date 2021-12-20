import 'package:gm_weather_app/utils/string_extension.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class Weather {
  final WeatherCondition condition;
  final String description;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final int cloudiness;
  String? humidity;
  final DateTime date;

  Weather(
      {required this.condition,
      required this.description,
      required this.temp,
      this.humidity,
      required this.cloudiness,
      required this.date,
      required this.maxTemp,
      required this.minTemp});

  static Weather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds']['all'];
    var weather = daily['weather'][0];

    return Weather(
        condition: mapStringToWeatherCondition(weather['main'], cloudiness),
        description: weather['description'].toString().capitalize(),
        cloudiness: cloudiness,
        temp: daily['main']['temp'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
            isUtc: true),
        minTemp: daily['main']['temp_min'].toDouble(),
        maxTemp: daily['main']['temp_max'].toDouble());
  }

  static WeatherCondition mapStringToWeatherCondition(
      String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }
}
