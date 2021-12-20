import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gm_weather_app/api/open_weather_map_weather_api.dart';
import 'package:gm_weather_app/models/forecast.dart';
import 'package:gm_weather_app/models/weather.dart';
import 'package:gm_weather_app/services/forecast_service.dart';
import 'package:gm_weather_app/utils/string_extension.dart';
import 'package:gm_weather_app/utils/temperature_convert.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  WeatherCondition _condition = WeatherCondition.unknown;
  late String _description;
  late double _minTemp;
  late double _maxTemp;
  late double _temp;
  late String _humidity;
  late int _locationId;
  late DateTime _lastUpdated;
  late String _city = "London";
  late List<Weather> _daily;
  late bool _isDayTime = true;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  String get humidity => _humidity;
  int get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String get city => _city;
  bool get isDaytime => _isDayTime;
  List<Weather> get daily => _daily;

  late ForecastService forecastService;

  ForecastViewModel() {
    getLatestWeather();
  }

  Future<void> getLatestWeather() async {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
    setRequestPendingState(true);
    isRequestError = false;

    late Forecast latest;
    try {
      await Future.delayed(const Duration(seconds: 1), () => {});

      latest = await forecastService.getWeather();
    } catch (e) {
      isRequestError = true;
    }
    isWeatherLoaded = true;
    if (!isRequestError) {
      updateModel(latest, "London");
    }

    setRequestPendingState(false);
    notifyListeners();
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isRequestError) return;

    _condition = forecast.current.condition;
    _city = forecast.city.capitalize();
    _description = forecast.current.description.capitalize();
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _minTemp = TemperatureConvert.kelvinToCelsius(forecast.current.minTemp);
    _maxTemp = TemperatureConvert.kelvinToCelsius(forecast.current.maxTemp);
    _humidity = forecast.current.humidity!;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }
}
