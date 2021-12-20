import 'package:gm_weather_app/api/weather_api.dart';
import 'package:gm_weather_app/models/forecast.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather() async {
    return await weatherApi.getWeather();
  }
}
