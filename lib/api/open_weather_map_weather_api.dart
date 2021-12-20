import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gm_weather_app/api/weather_api.dart';
import 'package:gm_weather_app/models/forecast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "e361af3f33e631b8d1fa0b6e79682ae5";
  late http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    httpClient = http.Client();
  }

  @override
  Future<Forecast> getWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const requestCurrent = '$endPointUrl/weather?q=london&appid=$apiKey';
    const requestNexts = '$endPointUrl/forecast?q=london&appid=$apiKey';
    try {
      final responseCurrent = await httpClient.get(Uri.parse(requestCurrent));
      final responseNexts = await httpClient.get(Uri.parse(requestNexts));
      if (responseCurrent.statusCode != 200) {
        throw Exception(
            'error retrieving current weather: ${responseCurrent.statusCode}');
      }
      await prefs.setString(
          'gm_weather_app_last_current_data', responseCurrent.body);
      await prefs.setString(
          'gm_weather_app_last_forecast_data', responseNexts.body);
      var timestamp = DateTime.now();
      await prefs.setString(
          'gm_weather_app_last_update_time', timestamp.toString());
      return Forecast.fromJson(jsonDecode(responseCurrent.body), timestamp,
          jsonDecode(responseNexts.body));
    } on SocketException catch (_) {
      String? lastupdate = prefs.getString('gm_weather_app_last_current_data');
      String? lastupdateForecast =
          prefs.getString('gm_weather_app_last_forecast_data');
      String? timestamp = prefs.getString('gm_weather_app_last_update_time');
      if (lastupdate != null &&
          timestamp != null &&
          lastupdateForecast != null) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

        return Forecast.fromJson(jsonDecode(lastupdate),
            dateFormat.parse(timestamp), jsonDecode(lastupdateForecast));
      }
      throw Exception('not connected - no local data available');
    }
  }
}
