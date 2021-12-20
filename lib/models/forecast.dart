import 'package:gm_weather_app/models/weather.dart';
import 'package:gm_weather_app/utils/string_extension.dart';

class Forecast {
  final DateTime lastUpdated;
  final List<Weather> daily;
  final Weather current;
  final bool isDayTime;
  final String city;

  Forecast(
      {required this.lastUpdated,
      this.daily = const [],
      required this.current,
      required this.city,
      required this.isDayTime});

  static Forecast fromJson(dynamic json, lastUpdated, [dynamic nextsData]) {
    var weather = json['weather'][0];
    var date =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    bool hasNexts = nextsData != null;
    List<Weather> tempDaily = [];
    if (hasNexts) {
      List items = nextsData['list'];
      for (dynamic item in items) {
        var dateTime =
            DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000, isUtc: true);
        if (dateTime.hour == 12) {
          tempDaily.add(Weather.fromDailyJson(item));
        }
        if (tempDaily.length == 5) break;
      }
    }

    var currentForcast = Weather(
        cloudiness: int.parse(json['clouds']['all'].toString()),
        temp: json['main']['temp'].toDouble(),
        condition: Weather.mapStringToWeatherCondition(
            weather['main'], int.parse(json['clouds']['all'].toString())),
        description: weather['description'].toString().capitalize(),
        date: date,
        humidity: json['main']['humidity'].toString(),
        minTemp: json['main']['temp_min'].toDouble(),
        maxTemp: json['main']['temp_max'].toDouble());
    return Forecast(
        lastUpdated: lastUpdated,
        current: currentForcast,
        daily: tempDaily,
        isDayTime: isDay,
        city: json['name']);
  }
}
