import 'package:gm_weather_app/models/forecast.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather();
}
